part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

final class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateLoginFailure extends AuthState {
  final Exception exception;

  const AuthStateLoginFailure(this.exception);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

class AuthStateLogOutFailure extends AuthState {
  final Exception exception;

  const AuthStateLogOutFailure(this.exception);
}
