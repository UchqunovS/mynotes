part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final String? loadingText;
  final bool? isLoading;
  const AuthState({
    this.loadingText = 'Please wait a moment',
    this.isLoading = false,
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({
    required bool super.isLoading,
  });
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    this.exception,
    super.loadingText = null,
    bool super.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}
