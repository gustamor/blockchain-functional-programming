import 'package:flutter/material.dart';
import 'package:functional_programming/app/presentation/modules/home/view/home_view.dart';
import 'package:functional_programming/app/presentation/modules/sign_in/sign_in_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blockchain Mega App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => const HomeView(),
        '/sign-in': (_) => const SignInView(),
      },
    );
  }
}
