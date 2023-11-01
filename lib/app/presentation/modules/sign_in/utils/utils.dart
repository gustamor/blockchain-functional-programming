
part of '../sign_in_view.dart';

String? _emailValidator(String text) {
  text = text.trim() ?? '';
  if (text.contains('@')) {
    return null;
  } else {
    return 'Invalid email';
  }
}

String ? _passwordValidator(String text) {
  text = text.trim() ?? '';
  if (text.isEmpty) {
    return 'Invalid password';
  } else {
    return null;
  }
}

Future<void> _submit(BuildContext context) async {
  final SignInBloc bloc = context.read();
  final result = await bloc.signIn();
  if (context.mounted) {
    result.when(
      left: (failure) => {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            failure.toString(),
          ),
        ))
      },
      right: (user) => {
        Navigator.pushReplacementNamed(context, '/'),
      },
    );
  }

}

