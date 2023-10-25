import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_events.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_state.dart';

import '../../../../domain/models/ws_status/ws_status.dart';
import '../../../../domain/repositories/exchange_repository.dart';
import '../../../../domain/repositories/ws_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    super.initialState, {
    required this.exchangerepository,
    required this.wsRepository,
  }) {
    on<InitializeEvent>(_onInitialize);
    on<UpdateWsStateEvent>(_onUpdatedStatus);
    on<UpdateCryptoPricesEvent>(_onUpdatedCryptoPriceEvent);
    on<DeleteEvent>((event, emit) {});
  }

  final _ids = [
    'bitcoin',
    'ethereum',
    'tether',
    'binance-coin',
    'usd-coin',
    'monero',
    'litecoin',
    'tomochain',
  ];

  final ExchangeRepository exchangerepository;
  final WsRepository wsRepository;
  StreamSubscription? _pricesSubscription, _wsSubscription;

  Future<void> _onInitialize(
    InitializeEvent event,
    Emitter<HomeState> emit,
  ) async {
    state.maybeWhen(
      loading: () => {},
      orElse: () => emit(
        HomeState.loading(),
      ),
    );

    final result = await exchangerepository.getPrices(_ids);

    emit(
      result.when(
        left: (failure) => HomeState.failed(failure),
        right: (cryptos) {
          startPricesListening();
          return HomeState.loaded(cryptos: cryptos);
        },
      ),
    );
  }

  void _onUpdatedStatus(UpdateWsStateEvent event, Emitter<HomeState> emit) {
    state.mapOrNull(
      loaded: (state) {
        emit(
          state.copyWith(wsStatus: event.wsStatus),
        );
      },
    );
  }

  void _onUpdatedCryptoPriceEvent(
    UpdateCryptoPricesEvent event,
    Emitter<HomeState> emit,
  ) {
    state.mapOrNull(
      loaded: (state) {
        final keys = event.prices.keys;
        emit(
          state.copyWith(
            cryptos: [
              ...state.cryptos.map(
                (crypto) {
                  if (keys.contains(crypto.id)) {
                    return crypto.copyWith(
                      price: event.prices[crypto.id]!,
                    );
                  }
                  return crypto;
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<bool> startPricesListening() async {
    final connected = await wsRepository.connect(_ids);

    add(UpdateWsStateEvent(
        connected ? const WsStatus.connected() : const WsStatus.failed()));

    await _wsSubscription?.cancel();
    await _pricesSubscription?.cancel();

    _wsSubscription = wsRepository.onStatusChanged.listen(
      (status) => add(
        UpdateWsStateEvent(status),
      ),
    );
    _pricesSubscription = wsRepository.onPricesChanged.listen(
      (prices) => add(
        UpdateCryptoPricesEvent(prices),
      ),
    );

    return connected;
  }

  void _onPricesChanged(Emitter<HomeState> emit) {
    _wsSubscription?.cancel();
  }

  @override
  Future<void> close() async {
    _wsSubscription?.cancel();
    _pricesSubscription?.cancel();
    return super.close();
  }
}
