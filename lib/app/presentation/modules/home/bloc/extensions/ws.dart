part of '../home_bloc.dart';

extension _WsExtension on HomeBloc{

  void _onUpdatedStatus(UpdateWsStateEvent event, Emitter<HomeState> emit) {
    state.mapOrNull(
      loaded: (state) {
        emit(
          state.copyWith(wsStatus: event.wsStatus),
        );
      },
    );
  }


  Future<bool> startPricesListening() async {
    final connected = await _wsRepository.connect(_ids);

    add(UpdateWsStateEvent(
        connected ? const WsStatus.connected() : const WsStatus.failed()));

    await _wsSubscription?.cancel();
    await _pricesSubscription?.cancel();

    _wsSubscription = _wsRepository.onStatusChanged.listen(
          (status) => add(
        UpdateWsStateEvent(status),
      ),
    );
    _pricesSubscription = _wsRepository.onPricesChanged.listen(
          (prices) => add(
        UpdateCryptoPricesEvent(prices),
      ),
    );

    return connected;
  }
}