import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/helpers/loading/loading_screen.dart';
import 'package:notes_app/services/auth/bloc/auth_bloc.dart';
import 'package:notes_app/services/auth/firebase_auth_provider.dart';
import 'package:notes_app/views/authentication/forgot_password_view.dart';
import 'package:notes_app/views/authentication/login_view.dart';
import 'package:notes_app/views/notes/create_update_note_view.dart';
import 'package:notes_app/views/notes/notes_view.dart';
import 'package:notes_app/views/authentication/register_view.dart';
import 'package:notes_app/views/authentication/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.isLoading ?? false) {
          case true:
            LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'Please wait a moment',
            );
            break;
          case false:
            LoadingScreen().hide();
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case AuthStateLoggedIn():
            return const NotesView();
          case AuthStateNeedsVerification():
            return const VerifyEmailView();
          case AuthStateLoggedOut():
            return const LoginView();
          case AuthStateRegistering():
            return const RegisterView();
          case AuthStateForgotPassword():
            return const ForgotPasswordView();
          default:
            return const Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}
