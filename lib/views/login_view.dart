// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/views/register_view.dart';

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
      appBar: AppBar(title: const Text('Log in'), centerTitle: true),
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
                final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case 'channel-error':
                    print(
                        '_________________________________ Both Fields are required ____________________________');
                    break;
                  case 'invalid-email':
                    print(
                        '_________________________________ Invalid Email ____________________________');
                    break;
                  case 'invalid-credential':
                    print(
                        '_________________________________ Password or email is wrong ____________________________');
                    break;
                  default:
                    print(e.code);
                }
              }
            },
            child: const Text('Log In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterView()),
                  (route) => false);
            },
            child: const Text('Have not registered yet? Register here'),
          ),
        ],
      ),
    );
  }
}
