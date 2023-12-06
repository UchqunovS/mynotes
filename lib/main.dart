import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/views/login_view.dart';
import 'package:notes_app/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Notes App',
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final bool emailVerified =
                FirebaseAuth.instance.currentUser?.emailVerified ?? false;
            if (emailVerified) {
              return const LogInView();
            } else {
              return const Center(
                child: Text('You need to verify your email first'),
              );
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
