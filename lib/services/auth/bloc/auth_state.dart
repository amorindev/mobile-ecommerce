part of 'auth_bloc.dart';

// ! usar solo copyWith con dataso que queremos guardar authresponse
// ! o otpId pero no para redirect exception loading si no tendremos
// ! comportamientos inesperados
// * sirve agregar equatable a estas clases VerifyOtpStatus
// * y como pasar el otpId entre estado anterior y actual
// como manejar los copyEith en VerifyOtpStatus y los estados y no perder
// como testear el bloc
// ? usar correctameente estas clases para mostrar el error VerifyOtpStatus
// ? y trabajo con ello  await showErrorDialog(context, verifyStatus.exception.toString());
// * recuerda que ambos tanto Session como User deben estar dentro de equatable
// * Agregar a todos props
// ! lo que pasa aqui es que comparten las variables todos los estados
// ! entonces por eso tenemos que verificar si es Sign in mostrar la carfa
@immutable
abstract class AuthState extends Equatable {
  final bool isLoading;
  final String? loadingText;
  // * De momento solo sera usado en enbletwofa ver flujo
  // * estaria bien por que esto parece el singleton de firebase
  // * el el user de supabase solo que en el bloc
  // TODO marcar required super.auhResponse en estados que cambian el user o la sssion
  // TODO verify otps hay varios que cambian al user o tambien en el propio AuthStateSignedIn
  // TODO y el authResponse del abstract lo dejamos como opciones
  // TODO para este bloc sacar el access token desde este estado y no desde el evento
  // TODO no va funcionar para otros Dominioos ver
  final AuthResponse? authResponse;

  //final Session? session;
  const AuthState({
    this.authResponse,
    //  this.session,
    required this.isLoading,
    this.loadingText,
  });

  // ! si es necesario su copiwith
  /*  AuthState copyWith({
    bool isLoading,
    String? loadingText,
    AuthResponse? authResponse,
    Session? session,
  }); */

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
  const AuthStateUninitialized({
    required super.isLoading,
    super.loadingText,
  });
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
  @override
  List<Object?> get props => [exception, isLoading, loadingText];
}

// usara el campo navigate?
// * si el backen retorna el usuario al sign up logout puede tener el user¡
class AuthStateSignedOut extends AuthState {
  final Exception? exception;

  const AuthStateSignedOut({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });

  @override
  List<Object?> get props => [exception, isLoading, loadingText];
}

class AuthStateSignedIn extends AuthState {
  //  obien estan sessui
  // ! final AuthResponse? authResponse;
  //final Session? session; de momento en authresponse esta la session ver cuando separarlo
  // o como manejarl0o
  final Exception? exception;
  // ! ambos no van a ser
  // ! ver que no se este mostrando dos veces el loading
  // porner un enum para saber si es sign in o verifacr otp y desde la ui
  // validar si es sign in y enum es sign in mostrar loading  lo mismo para log out
  final TwoFaData? twoFaData;
  final VerifyOtpStatus? verifyOtpStatus;
  const AuthStateSignedIn({
    required super.authResponse,
    required super.isLoading,
    this.twoFaData,
    this.verifyOtpStatus,
    this.exception,
    super.loadingText,
  });

  AuthStateSignedIn copyWith({
    AuthResponse? authResponse,
    bool? isLoading,
    Exception? exception,
    String? loadingText,
    TwoFaData? twoFaData,
    VerifyOtpStatus? verifyOtpStatus,
  }) {
    return AuthStateSignedIn(
      authResponse: authResponse ?? this.authResponse,
      isLoading: isLoading = false,
      exception: exception,
      loadingText: loadingText ?? this.loadingText,
      twoFaData: twoFaData ?? this.twoFaData?.copyWith(otpId: this.twoFaData?.otpId),
      verifyOtpStatus: verifyOtpStatus ,
    );
  }
  // imprimir con string
  @override
  List<Object?> get props => [
        authResponse,
        exception,
        twoFaData,
        verifyOtpStatus,
        isLoading,
        loadingText,
      ];
}

class TwoFaData extends Equatable {
  final String? otpId;
  // si el authresponse es opcional se puedeusar para este mismo para
  // veridicar two fa al iniciar session ver flujo cuando se va a retornar la session
  final bool isVerifying;
  final bool isSuccess;
  final Exception? exception;

  const TwoFaData({
    this.otpId,
    this.isVerifying = false,
    this.exception,
    this.isSuccess = false,
  });

  @override
  List<Object?> get props => [otpId, isVerifying, exception, isSuccess];

  TwoFaData copyWith({
    String? otpId,
    bool? isVerifying,
    bool? isSuccess,
    Exception? exception,
  }) {
    return TwoFaData(
      otpId: otpId ?? this.otpId,
      // me parece que esto es para la verificacion al hacer sign in 
      // y no crear otro estado oclase
      isVerifying: isVerifying ?? this.isVerifying,
      isSuccess: isSuccess = false,
      exception: exception ?? this.exception,
    );
  }
}

class VerifyOtpStatus extends Equatable {
  final Exception? exception;
  final bool isSuccess;
  final bool isLoading;

  const VerifyOtpStatus({
    this.exception,
    this.isSuccess = false,
    this.isLoading = false,
  });

  VerifyOtpStatus copyWith({
    Exception? exception,
    bool? isSuccess,
    bool? isLoading,
  }) {
    return VerifyOtpStatus(
      exception: exception,
      isSuccess: isSuccess = false,
      isLoading: isLoading = false,
    );
  }

  // ver que funcione por que aqui no tiene props
  @override
  String toString() => 'VerifyOtpStatus(success: $isSuccess, loading: $isLoading, exception: $exception)';

  @override
  List<Object?> get props => [exception, isLoading, isSuccess];
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

// AuthStateNeedsVerificationTwa no deberia ir dentro de este estado ver
class AuthStateNeedsVerification extends AuthState {
  final Exception? exp;
  final bool navigate;
  // ! esto sacarlo por que me parece que es para navegar
  //final AuthResponse authResponse;
  const AuthStateNeedsVerification({
    required this.navigate,
    this.exp,
    required super.authResponse, // aqui puedo marcarlo como requerid
    required super.isLoading,
    super.loadingText,
  });

  AuthStateNeedsVerification copyWith({
    Exception? exp,
    AuthResponse? authResp,
    bool? isLoading,
    String? loadingText,
    bool? navigate,
  }) {
    return AuthStateNeedsVerification(
      // si es nulo debe ser false para que no redireccione
      // sin motivo si uso copiy with y el anterir es true seguira navegando
      // sin control
      navigate: navigate ?? false,
      // no uso this por que es diferente nombre
      authResponse: authResp ?? authResponse,
      exp: exp,
      isLoading: isLoading ?? this.isLoading,
      loadingText: loadingText ?? this.loadingText,
    );
  }

  @override
  List<Object?> get props => [
        exp,
        authResponse,
        isLoading,
        loadingText,
      ];
}

// no  me sirve crearlo tanto asi de momento no se si se nota el loading
// ves que se repite con AuthStateNeedsVerification, por que no argrearle un enum
// y desde la ui validarlo if state is AuthStateNeedsVerification y el enum es
// AuthStateVerifyOtp mostrar el loading  o error, si necesito mas campos
// puedo mantener esta AuthStateVerifyOtp clase agregalo ahi o en el mismo  AuthStateNeedsVerification
// ver o que AuthStateVerifyOtp extienda de AuthStateNeedsVerification (la primera me parece mejor)
class AuthStateVerifyOtp {
  final Exception? exp;
  final bool isLoading;
  final bool isSuccess;
  const AuthStateVerifyOtp({
    this.exp,
    this.isSuccess = false,
    this.isLoading = false,
  });

  AuthStateVerifyOtp copyWith({
    Exception? exp,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return AuthStateVerifyOtp(
      exp: exp ?? this.exp,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// de momento no se para que se usa TwoFaData verifiyin campo
// de momento lo hare separado proque de momnento es para signedIn
// no se si combinarlo no se si retornar la session puede ser no
// por que ya se confirmo y ahora quereoms ver de momento separado
class AuthStateNeedsVerificationTwa extends AuthState {
  // se podría guardar la excepcion
  final String email;
  final String otpId;
  final bool navigate;
  final TwoFaSmsVerifyOtp? twoFaSmsVerifyOtp;
  const AuthStateNeedsVerificationTwa({
    required this.navigate,
    required this.email,
    required this.otpId,
    // ver por que no lo necesita loading
    required super.isLoading,
    this.twoFaSmsVerifyOtp,
  });

  AuthStateNeedsVerificationTwa copyWith({
    String? email,
    String? otpId,
    bool? isLoading,
    bool? navigate,
    TwoFaSmsVerifyOtp? twoFaSmsVerifyOtp,
  }) {
    return AuthStateNeedsVerificationTwa(
      email: email ?? this.email,
      otpId: otpId ?? this.otpId,
      isLoading: isLoading ?? this.isLoading,
      twoFaSmsVerifyOtp: twoFaSmsVerifyOtp ?? twoFaSmsVerifyOtp,
      navigate: navigate ?? false,
    );
  }

  @override
  List<Object?> get props => [
        email,
        otpId,
        isLoading,
        twoFaSmsVerifyOtp,
      ];
}

// cuando esta habilitado twofa al verificacion cuando inicio session
// * class TwoFaSmsVerifyOtp extends AuthStateNeedsVerificationTwa
// * se puede hacer eso ver para que no insertes directamente
// * el campo TwoFaSmsVerifyOtp dentro del estado
// * y ademasprueba si  te sale el mensaje de error
class TwoFaSmsVerifyOtp {
  final Exception? exp;
  final bool isLoading;
  final bool isSuccess;
  const TwoFaSmsVerifyOtp({
    this.exp,
    this.isSuccess = false,
    this.isLoading = false,
  });

  TwoFaSmsVerifyOtp copyWith({
    Exception? exp,
    bool? isSuccess,
    bool? isLoading,
  }) {
    return TwoFaSmsVerifyOtp(
      exp: exp ?? this.exp,
      isLoading: isLoading = false,
      isSuccess: isSuccess = false,
    );
  }
}

// ? que tipo de errores va a retornar la api
class AuthStateDeleteAccount extends AuthState {
  final Exception? exception;
  const AuthStateDeleteAccount({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
  @override
  // es para que escuche el listener
  List<Object?> get props => [exception, isLoading, loadingText];
}

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

// ! aqui ver por que al hacer sign in ya me estaretornaod
// ! la session el estado deberia ser signed in ver
// ! lo mismo para twofa verificar sign in
/* lo saque copia  no se si va seguir existinedo 
class AuthStateSignUpVerifyOtp extends AuthState {
  final Exception? exception;
  const AuthStateSignUpVerifyOtp({
    required this.exception,
    required super.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
} */

// showOnboarding o ppuede ser con shared preference
/* class AuthStateNewUser extends AuthState {
  final List<OnboardingResponse> onboardings;

  const AuthStateNewUser({
    required super.isLoading,
    super.loadingText,
    required this.onboardings,
  });
} */

class AuthStateSendEmailVerificationOTP extends AuthState {
  final Exception? exception;
  const AuthStateSendEmailVerificationOTP({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
  // * no se si se deben incluir todos los campos o cuales
  @override
  List<Object?> get props => [
        exception,
        isLoading,
        loadingText,
      ];
}
