// login exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register exceptions

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {
  // weincode agrega en las exceptiones el string mas limpio menos validaciones
  // veria para comparar con los mensajes del backend
  // aqui no lo mas cerca a la ui para internacionlizacion, no son para comparar con los
  // que vienen en el backend
  @override
  String toString() {
    return "email-already-in-use";
  }
}

class InvalidEmailAuthException implements Exception {}

// generic exceptions

class GenericAuthException implements Exception {
  @override
  String toString() => "generic-exception";
}

class UserNotLoggedInAuthException implements Exception {}

// mejor invalid session para cualquier relacionado al expiracion
// este si es propio de auth DDD ver los demas
class AccessTokenExpiredAuthExeption implements Exception {}
