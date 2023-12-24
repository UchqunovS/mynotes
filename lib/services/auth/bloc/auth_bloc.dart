import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/services/auth/auth_provider.dart';
import 'package:notes_app/services/auth/auth_user.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    // Send email verification
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
      },
    );
    //Registration
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(email: email, password: password);
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification());
        } on Exception catch (e) {
          emit(AuthStateRegistering(e));
        }
      },
    );
    // AuthEventShouldRegiser
    on<AuthEventShouldRegiser>(
      (event, emit) {
        emit(const AuthStateRegistering(null));
      },
    );
    // initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });
    // log in
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
        isLoading: true,
        loadingText: 'We are working for you, please sit back and wait :)',
      ));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut());
          emit(const AuthStateNeedsVerification());
        } else {
          emit(const AuthStateLoggedOut());
          emit(AuthStateLoggedIn(user));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
        ));
      }
    });
    // log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e));
      }
    });
  }
}
