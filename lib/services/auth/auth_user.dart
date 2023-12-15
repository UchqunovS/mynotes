import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  final bool isEmailVerified;
  final String? email;

  AuthUser({
    required this.isEmailVerified,
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email,
        isEmailVerified: user.emailVerified,
      );
}
