//  login exceptions
class UserNotFoundAuthException implements Exception {}

//  register exceptions
class WeakPasswordAuthAuthException implements Exception {}

class EmailIsAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class MissingPasswordOrEmailAuthException implements Exception {}

//  generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
