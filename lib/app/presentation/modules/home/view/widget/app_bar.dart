import 'package:flutter/material.dart';
import 'package:functional_programming/app/presentation/modules/global/blocs/session/session_events.dart';
import 'package:functional_programming/app/presentation/modules/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

import '../../../global/blocs/session/session_bloc.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = context.watch<HomeBloc>();
    final SessionBloc sessionBloc = context.watch<SessionBloc>();
    final isSignedIn = sessionBloc.state.user != null;
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (isSignedIn) {
            sessionBloc.add(SessionEvent.signOut());
          } else {
            Navigator.pushReplacementNamed(context, '/sign-in');
          }
      },
        icon:  Icon(isSignedIn ? Icons.person : Icons.login),
      ),
      title: homeBloc.state.mapOrNull(
          loaded: (state) => Center(
                child: Text(state.wsStatus.when(
                    connecting: () => 'connecting',
                    connected: () => 'connected',
                    failed: () => 'failed')),
              )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
