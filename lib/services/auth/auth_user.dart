import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  final String id;
  final bool isEmailVerified;
  final String email;

  AuthUser({
    required this.id,
    required this.isEmailVerified,
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        email: user.email!,
        isEmailVerified: user.emailVerified,
      );
}
