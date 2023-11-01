import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_programming/app/presentation/modules/global/cubits/dark_mode/dark_mode_cubit.dart';
import 'package:functional_programming/app/presentation/modules/home/view/home_view.dart';
import 'package:functional_programming/app/presentation/modules/sign_in/sign_in_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.watch<DarkModeCubit>().state;
    return MaterialApp(
      title: 'Blockchain Mega App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        '/': (_) => const HomeView(),
        '/sign-in': (_) => const SignInView(),
      },
    );
  }
}
