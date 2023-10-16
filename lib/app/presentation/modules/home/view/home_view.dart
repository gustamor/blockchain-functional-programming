import 'package:flutter/material.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(
          exchangerepository: context.read(), wsRepository: context.read())
        ..init(),
      // Escucha los cambios de estado (es  un Observable)
      builder: (context, _) {
        final HomeBloc bloc = context.watch<HomeBloc>();
        return Scaffold(
          appBar: AppBar(
            title: bloc.state.mapOrNull(
                loaded: (state) => Center(
                  child: Text(state.wsStatus.when(
                      connecting: () => 'connecting',
                      connected: () => 'connected',
                      failed: () => 'failed')),
                )),
          ),
          body: bloc.state.map(
            loading: ( _) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (state) {
              final message = state.failure.whenOrNull(
                  network: () => "Check your internet connection",
                  server: () => "Server failed",
                  notFound: () => "Resource not found",
                  unauthorized: () => "unauthorized",
                  badRequest: () => "Bad request",
                  local: () => "Resource not found");

              if (message == null) {
                return const SizedBox();
              }

              return Center(
                child: Text(message),
              );
            },
            loaded: (state) => ListView.builder(
              itemBuilder: (_, index) {
                final crypto = state.cryptos[index];
                return ListTile(
                    title: Text(crypto.id),
                    subtitle: Text(crypto.symbol),
                    trailing: Text(crypto.price.toStringAsFixed(2)));
              },
              itemCount: state.cryptos.length,
            ),
          ),
        );
      },
    );
  }
}
