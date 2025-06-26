import 'package:dio/dio.dart';
import 'package:flu_go_jwt/services/auth/exception/auth_exceptions.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/models/modelv2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// * como sincronizar el sign in con google con mi backend
// * como soportar web mobile al mismo tiempo agregar header platform, tambien sirviría para las sesiones
// * que to este vinculado al auth user
class AuthDioGateway implements AuthGateway {
  late final String _baseURL;
  late final Dio _dio;
  //late final SharedPreferences _localStorage;

  // ! como reponder correctamente me aparecia error en el provider uando no era eso si no
  // ! el .env condotenv
  AuthDioGateway() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("environment variabe API_URL is not set");
    }
    _baseURL = url;
    _dio = Dio(BaseOptions(
      validateStatus: (status) => status! <= 500,
    ));
    //_localStorage = SharedPreferences.getInstance();
  }

  @override
  Future<(AuthResponse?, Exception?)> signUp(
      {required String email, required String password, required String confirmPassword, String? name}) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'name': name,
      };

      final resp = await _dio.post("$_baseURL/v1/auth/sign-up", data: data);
      if (resp.statusCode == 200) {
        final user = AuthResponse.fromJson(resp.data);
        return (user, null);
      }
      //print(resp.statusCode);
      //print(resp.data);
      // ! asi para todos
      if (resp.statusCode == 404) {
        return (null, Exception("404 página no encontrada"));
      }
      if (resp.data['message'] == EmailAlreadyInUseAuthException().toString()) {
        return (null, EmailAlreadyInUseAuthException());
      }

      // si hay un error atraparlo con el catch o desde aqui?
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-signup";
      return (null, Exception(errMsg));
    } on DioException catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<Exception?> sendEmailVerificarionOTP({required email}) async {
    try {
      // si se produce un error manejalo ver
      final data = {'email': email};

      final resp = await _dio.post(
        "$_baseURL/v1/auth/send-email-verification-otp",
        data: data,
      );

      if (resp.statusCode == 200) {
        return (null);
      }
      // capturar el mensaje
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-signupverifyotp";
      return (Exception(errMsg));
    } catch (e) {
      //print("ApiDioGateway - sendEmailVerificarionOTP exception $e");
      return (Exception(e.toString()));
    }
  }

  @override
  Future<(AuthResponse?, Exception?)> signUpVerifyOtp({
    required String otpId,
    required String otpCode,
    required String email,
  }) async {
    try {
      final data = {"otp_id": otpId, "otp_code": otpCode, "email": email};

      final resp = await _dio.post(
        "$_baseURL/v1/auth/sign-up-verify-otp",
        data: data,
      );

      if (resp.statusCode == 200) {
        //print(resp.data);

        final authResp = AuthResponse.fromJson(resp.data);

        return (authResp, null);
      }
      // no se si esta bien final String txt; toma solo la primera asignacion?
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-signupverifyotp";
      return (null, Exception(errMsg));
    } catch (e) {
      //print("ApiDioGateway - signUpVerifyOtp exception $e");
      return (null, GenericAuthException());
    }
  }

  // * Documentar todos los errores y códigos que se van a devolcer
  @override
  Future<(AuthResponse?, Exception?)> signIn({
    required String email,
    required String password,
    bool? rememberMe,
  }) async {
    // ! arrglar os manejos de errores no me convencen
    try {
      final data = {'email': email, 'password': password, 'remember_me': rememberMe};

      final resp = await _dio.post("$_baseURL/v1/auth/sign-in", data: data);

      if (resp.statusCode == 200) {
        final session = AuthResponse.fromJson(resp.data);
        return (session, null);
      }
      final String errorMessage = resp.data['message'];
      //print("---------------mensaje de error---------------");
      //print(errorMessage);
      //print("----------------------------------------------");

      if (errorMessage == 'user-not-found') {
        return (null, UserNotFoundAuthException());
      }
      if (errorMessage == 'wrong-password') {
        return (null, WrongPasswordAuthException());
      }
      return (null, GenericAuthException());

      // ? Atrapar Dio excep o error general Exception
    } catch (e) {
      //print("ApiDioGateway - signIn exception $e");
      return (null, GenericAuthException());
    }
  }

  @override
  Future<(User?, Exception?)> getUser({
    required String accessToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      // * Realizar la petición
      final resp = await _dio.get(
        "$_baseURL/v1/auth/users/me",
        options: Options(headers: headers),
      );

      // * Procesar la respuesta
      if (resp.statusCode == 200) {
        final authResponse = User.fromJson(resp.data);
        return (authResponse, null);
      }
      if (resp.statusCode == 401) {
        return (null, AccessTokenExpiredAuthExeption());
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-getUser";
      return (null, Exception(errMsg));
    } catch (e) {
      //print("ApiDioGateway - getUser exception $e");
      return (null, GenericAuthException());
    }
  }

  /* @override
  Future<(AuthResponse?, Exception?)> getSession({
    required String accessToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      // * Realizar la petición
      final resp = await _dio.get(
        "$_baseURL/v1/auth/get-session",
        options: Options(headers: headers),
      );

      // * Procesar la respuesta
      if (resp.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(resp.data);
        return (authResponse, null);
      }
      if (resp.statusCode == 401) {
        return (null, AccessTokenExpiredAuthExeption());
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-getUser";
      return (null, Exception(errMsg));
    } catch (e) {
      //print("ApiDioGateway - getSession exception $e");
      return (null, GenericAuthException());
    }
  } */

  @override
  Future<(Session?, Exception?)> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final data = {"refresh_token": refreshToken};
      final resp = await _dio.post(
        "$_baseURL/v1/auth/refresh-token",
        data: data,
      );
      if (resp.statusCode == 200) {
        final session = Session.fromJson(resp.data);
        return (session, null);
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-refreshToken";
      return (null, Exception(errMsg));
    } catch (e) {
      //print("ApiDioGateway - refreshToken exception $e");
      return (null, GenericAuthException());
    }
  }

  @override
  Future<Exception?> signOut({required String refreshToken}) async {
    try {
      final data = {"refresh_token": refreshToken};
      final resp = await _dio.post(
        "$_baseURL/v1/auth/sign-out",
        data: data,
      );
      if (resp.statusCode == 200) {
        return (null);
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-refreshToken";
      return (Exception(errMsg));
    } catch (e) {
      return (Exception(e.toString()));
    }
  }

  // ! en on DioException catch (e), llegará el 'message' del error  o desde try
  // ! reescribir el manejo de errores
  @override
  Future<(AuthResponse?, String?)> googleSignIn({required String tokenId}) async {
    try {
      // ? El token se envía en el header ?
      final data = {'token_id': tokenId};
      final headers = {'Content-Type': 'application/json'};

      final resp = await _dio.post(
        '$_baseURL/v1/auth/google',
        data: data,
        options: Options(headers: headers),
      );
      if (resp.statusCode != 200) {
        final String errorMessage = resp.data['message'] ?? "Error desconocido";
        return (null, errorMessage);
      }
      final session = AuthResponse.fromJson(resp.data);
      // * si genera error ponerlo dentro de try catch arriba
      return (session, null);
    } on DioException catch (e) {
      String errorMsg = "Err conection";

      /* si es dio exception no se cada mesage message se saca arriba 
      if (e.response != null) {
        //errorMsg = e.response!.data['message'] ?? "";
      } else */
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMsg = "Tiempo de connección agotado";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMsg = "Tiempo de espera agotado al recibir datos";
      } else if (e.type == DioExceptionType.badResponse) {
        errorMsg = "Respuesta incorrecta del servidor";
      } else if (e.type == DioExceptionType.unknown) {
        errorMsg = "Error inesperado";
      } else {
        errorMsg = e.toString();
      }
      //return (null, e.toString());
      return (null, errorMsg);
    }
  }

  @override
  Future<Exception?> sendEmailVerification({required String email}) async {
    return Exception("sendEmailVerification not implement");
  }

  @override
  Future<Exception?> sendForgotPassword({required String email}) async {
    try {
      final data = {'email': email};

      final resp = await _dio.post(
        "$_baseURL/v1/auth/forgot-password",
        data: data,
      );
      if (resp.statusCode == 200) {
        //print("------------sendEmailVerificarion200");
        //print(resp.data);
        //print("------------sendEmailVerificarion200");
        return null;
      }
      //print("------------sendEmailVerificarion!=200");
      final String errMsg = resp.data['message'] ?? "error-message-not-found-sendemailverification";
      if (errMsg == "user-not-found") {
        return UserNotFoundAuthException();
      }
      if (errMsg == "invalid-email") {
        return InvalidEmailAuthException();
      }
      //print("-------------Generic error sendForgotPassword ");
      return GenericAuthException();
    } on DioException catch (_) {
      //print("-------------Generic error sendForgotPassword 2");

      return GenericAuthException();
    }
  }

  @override
  Future<Exception?> deleteAccount({
    required accessToken,
    required password,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      final data = {
        'password': password,
      };
      final resp = await _dio.post(
        "$_baseURL/v1/auth/delete-account",
        data: data,
        options: Options(headers: headers),
      );

      if (resp.statusCode == 200) {
        return null;
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-delete-account";
      return (Exception(errMsg));
      //! controlar todos los errores < 500 como pusiste al configurar
      // ! la instancia de DIo si no DioException no lo atrapra
      // ! si el metodo POST no esta permitido devolvera metodo nor Allow sin formato
      // ! y sausarpa error errMsg = resp.data['message']
    } on DioException catch (e) {
      return (Exception(e.toString()));
    } catch (e) {
      // ! ver que vas a manejar condigurar dio correctamente
      return (Exception(e.toString()));
    }
  }

  @override
  Future<(String?, Exception?)> enableTwoFaSms({
    required String accessToken,
    required String phoneId,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      final data = {
        'phone_id': phoneId,
      };
      final resp = await _dio.post(
        "$_baseURL/v1/auth/enable-2fa-sms",
        data: data,
        options: Options(headers: headers),
      );

      

      if (resp.statusCode == 200) {
        // ? verificar que no venga nulo
        final otpCode = resp.data['otp_id'] as String?;
        return (otpCode, null);
      }


      if (resp.statusCode == 401) {
        return (null, AccessTokenExpiredAuthExeption());
      }
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-enabletwoFaSms";
      return (null, Exception(errMsg));
    } catch (e) {
      // ? usar este para cualquier exception on Exception
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<(User?, Exception?)> enableTwoFaSmsVerifyOtp({
    required String accessToken,
    required String otpId,
    required String otpCode,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        //'Custom-Header': 'valor_personalizado',
      };

      final data = {
        'otp_id': otpId,
        'otp_code': otpCode,
      };

      final resp = await _dio.post(
        "$_baseURL/v1/auth/enable-2fa-sms-verify-otp",
        data: data,
        options: Options(headers: headers),
      );

      if (resp.statusCode == 200) {
        final user = User.fromJson(resp.data);
        return (user, null);
      }
      if (resp.statusCode == 401) {
        return (null, AccessTokenExpiredAuthExeption());
      }

      // no se si esta bien final String txt; toma solo la primera asignacion?
      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-enabletwoFaSmsverifyotp";
      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<(AuthResponse?, Exception?)> twoFaSmsVerifyOtp({
    required String otpId,
    required String otpCode,
  }) async {
    try {
      final data = {
        'otp_id': otpId,
        'otp_code': otpCode,
      };
      // ! verificar todo el manejo de errores
      // ! desde catch Expetcion solo catch o Catch DioExeotion
      // ! tambien cuando 404 page not found comomanejarlo y me parece
      // ! que no se muestra en la ui es un internal errr
      final resp = await _dio.post(
        "$_baseURL/v1/auth/two-fa-sms-verify-otp",
        data: data,
      );
      //print(resp.statusCode);
      //print(resp.data);
      if (resp.statusCode == 200) {
        final auth = AuthResponse.fromJson(resp.data);
        return (auth, null);
      }
      if (resp.statusCode == 401) {
        return (null, AccessTokenExpiredAuthExeption());
      }

      String errMsg;
      errMsg = resp.data['message'] ?? "err-msg-not-found-twoFaSmsVerifyOtp";
      return (null, Exception(errMsg));
    } catch (e) {
      //print('twoFaSmsVerifyOtp err: ${e.toString()}');
      return (null, Exception(e.toString()));
    }
  }
}


// * tenemos observaciones en cuando a la arquitectura
// * si dejamos aqui shared preferences cuando cambiemo de dio u otro tambien tenemos que modificar y viceversa
// * primera solucion injectar al bloc shared preferences service, provider service (google apple)
// * deberia sacar una carpeta por proveedor o juntar todo en auth service mas clean es sacar
// * primera solucion auth tienen sign in sign up y con social medias 
// * otra forma es sacar service capa para que interactue con shred preferences dio solicitudes, y google services

// ? si es google sig in usar m propio token de de google y cómo validarlo
// * ¿Qué hace internamente?
// * No hace una request al servidor en cada getCurrentUser(), solo usa la info almacenada localmente.
// * El token se refresca automáticamente en segundo plano si la sesión sigue activa.


/*

final Dio _dio;
  final String baseURL = '${Env.apiURL}/v1/auth';

  MybackAuthProvider()
      : _dio = Dio(
          BaseOptions(
            baseUrl: '${Env.apiURL}/v1/auth',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            // para el auth changes no es necesario
            headers: {'Content-Type': 'application/json'},
          ),
        );
 */

// * Si ocurre un error en DIo
/*
on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        //return (null, Exception("Tiempo de connección agotado"));
        return (null, GenericAuthException());
      } else if (e.type == DioExceptionType.receiveTimeout) {
        //return (null, Exception("Tiempo de espera agotado al recibir datos"));
        return (null, GenericAuthException());
      } else if (e.type == DioExceptionType.badResponse) {
        //return (null, Exception("Respuesta incorrecta del servidor"));
        return (null, GenericAuthException());
      } else if (e.type == DioExceptionType.unknown) {
        //return (null, Exception("Error inesperado"));
        return (null, GenericAuthException());
      }
      //return (null, Exception(errMsg + e.toString()));
      return (null, GenericAuthException());
    }

 */