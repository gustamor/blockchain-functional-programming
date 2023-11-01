import 'package:flutter/widgets.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class HomeError extends StatelessWidget {
  const HomeError({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.watch<HomeBloc>();

    return bloc.state.maybeWhen(orElse: () => const SizedBox(),
        failed: (failure) {
          final message = failure.whenOrNull(
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
        }
    );
  }
}
