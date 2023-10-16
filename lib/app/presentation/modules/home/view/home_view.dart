import 'package:flutter/material.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:functional_programming/app/presentation/modules/home/view/widget/app_bar.dart';
import 'package:provider/provider.dart';

import 'widget/error.dart';
import 'widget/loaded.dart';

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
          appBar: HomeAppBar(),
          body: bloc.state.map(
            loading: ( _) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => const HomeError(),
            loaded: (_) => const HomeLoaded()
          ),
        );
      },
    );
  }
}
