import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_events.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_state.dart';

import '../../../../domain/models/ws_status/ws_status.dart';
import '../../../../domain/repositories/exchange_repository.dart';
import '../../../../domain/repositories/ws_repository.dart';

part 'extensions/update_crypto_prices.dart';
part 'extensions/ws.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    super.initialState, {
    required this.exchangeRepository,
    required WsRepository wsRepository,
  }) : _wsRepository = wsRepository {
    on<InitializeEvent>(_onInitialize);
    on<UpdateWsStateEvent>(_onUpdatedStatus);
    on<UpdateCryptoPricesEvent>(_onUpdatedCryptoPriceEvent);
    on<DeleteEvent>(_onDelete);
  }
  final _ids = [
    'bitcoin',
    'ethereum',
    'tether',
    'binance-coin',
    'usd-coin',
    'monero',
    'litecoin',
    'eos',
  ];

  final WsRepository _wsRepository;

  StreamSubscription? _pricesSubscription, _wsSubscription;

  final ExchangeRepository exchangeRepository;

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

    final result = await exchangeRepository.getPrices(_ids);

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

  void _onDelete(DeleteEvent event, Emitter<HomeState> emit) {
    state.mapOrNull(loaded: (state) {
      final cryptos = [...state.cryptos];
      cryptos.removeWhere((element) => element.id == event.crypto.id);
      emit(state.copyWith(cryptos: cryptos));
    });
  }

  @override
  Future<void> close() async {
    _wsSubscription?.cancel();
    _pricesSubscription?.cancel();
    return super.close();
  }
}
