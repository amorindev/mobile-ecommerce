part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventEnableMfaSms extends AuthEvent {
  final String accessToken;
  final String phoneId;
  const AuthEventEnableMfaSms({
    required this.accessToken,
    required this.phoneId,
  });
}

class AuthEventRefreshToken extends AuthEvent {
  const AuthEventRefreshToken();
}

// con el usuario actual
class AuthEventResendVerifyEmailOtp extends AuthEvent {
  const AuthEventResendVerifyEmailOtp();
}

class AuthEventResendVerifyEnableMfaSmsOtp extends AuthEvent {
  const AuthEventResendVerifyEnableMfaSmsOtp();
}

class AuthEventResendVerifyMfaSmsOtp extends AuthEvent {
  const AuthEventResendVerifyMfaSmsOtp();
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;
  const AuthEventSignIn({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut();
}

// * ver si se va a mostrar un error mejor simple si
// * sucede un error solo enviamos a signin
// * ya despues vemos que errores debemos mostrar
class AuthEventSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String confirmPassword;

  const AuthEventSignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class AuthEventVerifyEmailOtp extends AuthEvent {
  //final String otpId; lo obtendré desde el bloc no es algo que inserte el usuario
  final String otpCode;
  //final String email; lo obtendré desde el bloc no es algo que inserte el usuario

  const AuthEventVerifyEmailOtp({
    //required this.otpId,
    required this.otpCode,
    //required this.email,
  });
}

class AuthEventVerifyEnableMfaSmsOtp extends AuthEvent {
  final String accessToken;
  final String otpId;
  final String otpCode;

  const AuthEventVerifyEnableMfaSmsOtp({
    required this.accessToken,
    required this.otpId,
    required this.otpCode,
  });
}

class AuthEventVerifyMfaSmsOtp extends AuthEvent {
  final String otpCode;

  const AuthEventVerifyMfaSmsOtp({
    required this.otpCode,
  });
}
