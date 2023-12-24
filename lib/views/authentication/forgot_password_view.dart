import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/services/auth/bloc/auth_bloc.dart';
import 'package:notes_app/utilities/dialogs/error_dialog.dart';
import 'package:notes_app/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSendEmail) {
            _controller.clear();
            await showPasswordResetEmailSenTDialog(context);
          }
          if (state.exception != null && context.mounted) {
            await showErrorDialog(context,
                'We could not find this user, if you think this is an error please contact to the devloper');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot password')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('You can reset your password here'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter you email here',
                ),
              ),
              TextButton(
                onPressed: () {
                  final email = _controller.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotPassword(email: email));
                },
                child: const Text('Send password reset email'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text('Go back to login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
