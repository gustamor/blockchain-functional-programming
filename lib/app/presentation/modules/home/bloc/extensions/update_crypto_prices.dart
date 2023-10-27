part of '../home_bloc.dart';

extension _UpdateCryptoPrices on HomeBloc{
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
}