import 'package:flu_go_jwt/services/auth/domain/domainv2.dart';

// ! ya no se va usar jwt sino otp codes ver si trabajan ambos para restablecer contraseña
// ! vi que se usaban ambos ver
// supabase  y firebase tienen sign up anonimus o mas cosas al sign up puedes agregarle
// {} parámetros no requeridos como phone y otros
// * Ver en que casos usar objetos como create Signup junto UserCreateRequest
// ? Retornar Exception o el mi AuthException que engloba todas las exceptiones ?
//
// ! de igual manera separar  las responses y rewquest
abstract class AuthGateway {

  // Habilita MfaSms, String es el otpId
  Future<(String?, Exception?)> enableMfaSms({
    required String accessToken,
    required String phoneId,
  });

  // * El usuario solicita un nuevo token y refreshtoken(Opcinal), si el actual expira
  Future<(AuthResponse?, Exception?)> refreshToken({
    //required String accessToken, // * de momento no lo vamos a invalidar
    required String refreshToken,
  });

  // * Si no le llega el correo puede solicitar otro
  // ! verificar si es correcto, podiar ser un error o bool
  Future<Exception?> resendVerifyEmailOtp({required String email});

  // ? verificar que exista el usuario
  Future<Exception?> resendVerifyEnableMfaSmsOtp({required String email});

  Future<Exception?> resendVerifyMfaSmsOtp({required String email});

  Future<(AuthResponse?, Exception?)> signIn({
    required String email,
    required String password,
    bool? rememberMe,
  });

  // otpid y session seran nulos
  // ! get session o credentials
  //Future<(AuthResponse?, Exception?)> getSession({required String accessToken});

  // * eliminar la session mediante el id del refreshtoken
  // ? deberia retornr un error firebse si lo hace
  // ? pero que error cuando invalido el session o jwt del backend pero eso con un cron job se elimina
  // ? que pasa si se elimina la session y da un error al eliminar de local storage
  // * para eliminar de local storage no es necesaario que pare la ejecucuon por que cundo ingreso uno nuevo,
  // * si da error primero mero pregunto si hay data
  // * que paso seria cortante que no tenga conexion? de dio o algo asi ver
  Future<Exception?> signOut({required String refreshToken});

  // * Usuario se registra
  // * necesito el auth por que incuye el otp_id no solo el user
  Future<(AuthResponse?, Exception?)> signUpOtp({
    String? name,
    required String email,
    required String password,
    required String confirmPassword,
  });

// Auth templete se vasa en seguridad casos de uso
  // retornar la session cuando se verifico
  // TODO en el tema de verofyotp se esta retornando el user
  // TODO asegurarse de cambiar solamente el user y no todo
  // TODO se podria haber retornado todo el response pero con datos nulos ver
  // * Envía el otp al backend para su validación
  Future<(AuthResponse?, Exception?)> verifyEmailOtp({
    required String otpId,
    required String otpCode,
    required String email,
  });

  Future<(User?, Exception?)> verifyEnableMfaSmsOtp({
    required String accessToken,
    required String otpId,
    required String otpCode,
  });

  // ! el otp tiene su userid asi que no es neceasartion enviarlo o el email revadar
  // * Esto es cuando hace login el otro es cuando habilita
  // *  estamos creando handlers para cada proveedor sms o phone
  // * me parece que es mejor un parametro y dependiendo eso
  // * par no crear varios handlers
  // * lo mismo para phones /user/phones ver
  // * solo necesito eso  por que no tengo que actualizar mi user
  // * creo que no es necesario verificar si existe el usario y envirale el id
  Future<(AuthResponse?, Exception?)> verifyMfaSmsOtp({
    required String otpId,
    required String otpCode,
  });
}
