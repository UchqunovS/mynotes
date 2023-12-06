// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/views/login_view.dart';

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
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Email here'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(hintText: 'Password here'),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          TextButton(
            onPressed: () async {
              final String email = _email.text;
              final String password = _password.text;
              try {
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case 'channel-error':
                    print(
                        '_________________________________Empty Stamp____________________________');
                    break;
                  case 'invalid-email':
                    print(
                        '_________________________________ Invalid Email ____________________________');
                    break;
                  case 'weak-password':
                    print(
                        '_________________________________ Weak Password ____________________________');
                    break;
                  case 'email-already-in-use':
                    print(
                        '_________________________________ Email Already In Use ____________________________');
                    break;
                  default:
                    print(e.code);
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInView()),
                  (route) => false);
            },
            child: const Text('Already registered yet? Log In here'),
          ),
        ],
      ),
    );
  }
}
