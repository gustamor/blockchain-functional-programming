import 'package:flutter/material.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/crypto/crypto.dart';

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();

   return bloc.state.maybeWhen(orElse: () => SizedBox(),
      loaded: (cryptos, _) {
        return ListView.builder(
          itemBuilder: (_, index) {
            final crypto = cryptos[index];
            return ListTile(
                title: Text(crypto.id),
                subtitle: Text(crypto.symbol),
                trailing: Text(crypto.price.toStringAsFixed(2)));
          },
          itemCount: cryptos.length,
        );
      }
    );
  }
}
