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
        sessionBloc: context.read(),
        authRepository: context.read(),
      ),
      child: Builder(builder: (context) {
        final SignInBloc bloc = context.read();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<SignInBloc, SignInState>(
              buildWhen: (prev, current) => prev.fetching != current.fetching,
              builder: (context, state) {
                return AbsorbPointer(
                  absorbing: state.fetching,
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
                          validator: (text) => emailValidator(text??'')

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
                          validator: (text) => passwordValidator(text??'')
                        ),
                        const SizedBox(height: 16),
                        Builder(
                          builder: (context) {
                            final termsAccepted =
                                context.select<SignInBloc, bool>(
                                    (bloc) => bloc.state.termsAccepted);

                            return CheckboxListTile(
                              value: termsAccepted,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (checked) => bloc.add(
                                SignInEvent.termsAccepted(
                                  checked ?? false,
                                ),
                              ),
                              title: const Text("Are you ok with the terms?"),
                            );
                          },
                        ),
                        state.fetching
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Builder(
                              builder: (mContext) {
                                final state = context.watch<SignInBloc>().state;
                                final enabled = state.termsAccepted &&
                                    emailValidator(state.email)   &&
                                   passwordValidator(state.password);
                                return  ElevatedButton(
                                    onPressed: enabled ? () => _submit(context) : null,
                                    child: Text("Sign in"),
                                  );
                              },
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

}



emailValidator(String text) {
  text = text?.trim() ?? '';
  if (text.contains('@')) {
    return null;
  } else {
    return 'Invalid email';
  }

}
passwordValidator(String text) {
  text = text?.trim() ?? '';
  if (text.isEmpty) {
    return 'Invalid Password';
  } else {
    return null;
  }
}

 Future<void> _submit(BuildContext context)async{
 final SignInBloc bloc = context.read();
 final result = await bloc.signIn();
 if (context.mounted) {
   result.when(left: (failure) => {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(failure.toString(),),)
     )
   }, right: (user) =>
   {
     Navigator.pushReplacementNamed(context, '/'),
   },);
 } else {
   print('Deactivated widget');
 }

}