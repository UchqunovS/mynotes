// login exceptions
class WrongCredentialsdAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

// register exceptions

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidFillingAuthException implements Exception {}

// generic exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
