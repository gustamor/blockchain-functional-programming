import 'package:flutter/material.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.watch<HomeBloc>();

    return AppBar(
      title: bloc.state.mapOrNull(
          loaded: (state) => Center(
            child: Text(state.wsStatus.when(
                connecting: () => 'connecting',
                connected: () => 'connected',
                failed: () => 'failed')),
          )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
