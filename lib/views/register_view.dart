// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Insert Your Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration:
                const InputDecoration(hintText: 'Create A New Password'),
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
                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on MissingPasswordOrEmailAuthException {
                await showErrorDialog(context, 'Both fields are required');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid email');
              } on WeakPasswordAuthAuthException {
                await showErrorDialog(context, 'Weak password');
              } on EmailIsAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email is already in use');
              } on GenericAuthException {
                await showErrorDialog(context, 'Could not create a user');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered yet? Log In here'),
          ),
        ],
      ),
    );
  }
}
