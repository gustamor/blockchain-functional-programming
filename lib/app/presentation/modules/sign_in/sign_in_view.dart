import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_programming/app/presentation/modules/sign_in/bloc/sign_in_bloc.dart';
import 'package:functional_programming/app/presentation/modules/sign_in/bloc/sign_in_event.dart';
import 'package:functional_programming/app/presentation/modules/sign_in/bloc/sign_in_state.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (_) => SignInBloc(
        SignInState(),
      ),
      child: Builder(builder: (context) {
        final SignInBloc bloc = context.read();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                    onChanged: (text) => bloc.add(
                      SignInEvent.emailChanged(
                        text.trim(),
                      ),
                    ),
                    validator: (text) {
                      text = text?.trim() ?? '';
                      if (text.contains('@')) {
                        return null;
                      } else {
                        return 'Invalid email';
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                    onChanged: (text) => bloc.add(
                      SignInEvent.passwordChanged(
                        text.trim(),
                      ),
                    ),
                    validator: (text) {
                      text = text?.trim() ?? '';
                      if (text.isEmpty) {
                        return 'Invalid Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      return CheckboxListTile(
                          value: bloc.state.termsAccepted,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (checked) => bloc.add(
                                SignInEvent.termsAccepted(
                                  checked ?? false,
                                ),
                              ),
                          title: const Text("Are you ok with the terms?"));
                    },
                  ),
                  const ElevatedButton(
                    onPressed: null,
                    child: Text("Sign in"),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
