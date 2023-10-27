import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(label: Text('Password')),
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
              CheckboxListTile(
                value: false,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (checked) {},
                title: const Text("Are you ok with the terms?")
              ),
              ElevatedButton(
                onPressed: null,
                child: Text("Log in"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
