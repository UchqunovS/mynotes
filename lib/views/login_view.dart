// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/utilities/show_error_dialog.dart';

class LogInView extends StatefulWidget {
  const LogInView({
    super.key,
  });

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log in')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration:
                const InputDecoration(hintText: 'Enter Your Email here'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration:
                const InputDecoration(hintText: 'Enter Your Password here'),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          TextButton(
            onPressed: () async {
              final String email = _email.text;
              final String password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              } on MissingPasswordOrEmailAuthException {
                await showErrorDialog(context, 'Both Fields are required');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid Email');
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Could not log in with pprovided details, make sure they are valid',
                );
              }
            },
            child: const Text('Log In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Have not registered yet? Register here'),
          ),
        ],
      ),
    );
  }
}
