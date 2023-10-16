import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:functional_programming/app/domain/repositories/exchange_repository.dart';
import 'package:functional_programming/app/domain/repositories/ws_repository.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_state.dart';


class HomeBloc extends ChangeNotifier {
  HomeBloc({required this.wsRepository, required this.exchangerepository});

  final ExchangeRepository exchangerepository;
  final WsRepository wsRepository;
  StreamSubscription? _subscription;

  HomeState _state = HomeState.loading();

  HomeState get state => _state;

  final _ids = [
    'bitcoin',
    'litecoin',
    'ethereum',
    'usd-coin',
    'monero',
    'tomochain'
  ];

  Future<void> init() async {
    state.maybeWhen(
        loading: () => {},
        orElse: () => {_state = HomeState.loading(), notifyListeners()});

    final result = await exchangerepository.getPrices(_ids);

    _state = result.when(
        left: (failure) => HomeState.failed(failure),
        right: (cryptos) {
          startPricesListening();
          return HomeState.loaded(cryptos: cryptos);
        });

    notifyListeners();
  }

  Future<bool> startPricesListening() async {
    final connected = await wsRepository.connect(_ids);
    if (connected) {
      _onPricesChanged();
    }
    state.mapOrNull(
      loaded: (state) {
        _state = state.copyWith(
            wsStatus: connected
                ? const WsStatus.connected()
                : const WsStatus.failed());
        notifyListeners();
      },
    );

    return connected;
  }

  void _onPricesChanged() {
    _subscription?.cancel();
    _subscription = wsRepository.onPricesChanged.listen((changes) {
      state.mapOrNull(
        loaded: (state) {
          final keys = changes.keys;

          _state = state.copyWith(
            cryptos: [...state.cryptos.map(
                  (crypto) {
                if (keys.contains(crypto.id)) {
                  return crypto.copyWith(
                    price: changes[crypto.id]!,
                  );
                }
                return crypto;
              },
            )],
          );
          notifyListeners();
        },
      );
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
