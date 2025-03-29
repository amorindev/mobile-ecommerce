part of 'auth_bloc.dart';

// * recuerda que ambos tanto Session como User deben estar dentro de equatable
// * Agregar a todos props
@immutable
abstract class AuthState extends Equatable {
  final bool isLoading;
  final String? loadingText;
  const AuthState({required this.isLoading, this.loadingText});

  @override
  List<Object?> get props => [isLoading, loadingText];
}

// ? como manejo props si es User entidad  lo mismo para event
//class AuthInitial extends AuthState {}
/* class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading, String? loadingText})
      : super(isLoading: isLoading, loadingText: loadingText);
}
 */
class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading, super.loadingText});
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
}

class AuthStateSignedIn extends AuthState {
  final Session session;
  final User user;
  const AuthStateSignedIn({
    required this.session,
    required this.user,
    required super.isLoading,
    super.loadingText,
  });
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  // cuando el backen emvia el correo esperar el rusultado
  // o no ya no usariamos  gorutine go
  // para verificar si se envio correctamente
  // pero para verificar cuenta lo mismo o usamos gorutinas
  final bool hasSentEmail;

  const AuthStateForgotPassword({
    required super.isLoading,
    required this.exception,
    required this.hasSentEmail,
    super.loadingText,
  });
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({
    required super.isLoading,
    super.loadingText,
  });
}

// * si el backen retorna el usuario al sign up logout puede tener el user¡
class AuthStateSignedOut extends AuthState {
  final Exception? exception;
  const AuthStateSignedOut({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });

  @override
  List<Object?> get props => [exception];
}

// * definir los flujos cortantes por ejemplo
// * eliminar el refreshtoken de redis no estan importante
// * eliminar la session de local storage no tan importante
// * o si uno de elllos es imp

class AuthStateBranchIoStateDeepLinkToken extends AuthState {
  final String token;
  const AuthStateBranchIoStateDeepLinkToken({
    required this.token,
    required super.isLoading,
    super.loadingText,
  });

  @override
  List<Object> get props => [token];
}
