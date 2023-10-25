import 'package:flutter/material.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_events.dart';
import 'package:functional_programming/app/presentation/modules/home/view/widget/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_state.dart';
import 'widget/error.dart';
import 'widget/loaded.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(
        HomeState.loading(),
        exchangerepository: context.read(),
        wsRepository: context.read(),
      )..add(
          InitializeEvent(),
        ),
      child: Builder(
        builder: (context) {
          HomeBloc bloc = context.watch();
          return Scaffold(
            backgroundColor: const Color(0xfff2f5f8),
            appBar: HomeAppBar(),
            body: bloc.state.map(
              loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              failed: (_) => const HomeError(),
              loaded: (_) => const HomeLoaded(),
            ),
          );
        },
      ),
    );
  }
}
