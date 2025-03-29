import 'package:dio/dio.dart';
import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

// * como sincronizar el sign in con google con mi backend
// * como soportar web mobile al mismo tiempo agregar header platform, tambien sirviría para las sesiones
// * que to este vinculado al auth user
class ApiDioGateway implements AuthGateway {
  late final String _baseURL;
  late final Dio _dio;
  //late final SharedPreferences _localStorage;

  // ! como reponder correctamente me aparecia error en el provider uando no era eso si no
  // ! el .env condotenv
  ApiDioGateway() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("environment variabe API_URL is not set");
    }
    url.toString().log();
    _baseURL = url;
    _dio = Dio(BaseOptions());
    //_localStorage = SharedPreferences.getInstance();
  }

  @override
  Future<(User?, Exception?)> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        "confirm_password": confirmPassword
      };

      final resp = await _dio.post("$_baseURL/v1/auth/sign-up", data: data);
      if (resp.statusCode == 200) {
        resp.data.log();
        final session = User.fromJson(resp.data);
        return (session, null);
      }

      // si hay un error atraparlo con el catch o desde aqui?
      final String errMsg = resp.data['message'] ?? "error-message-not-found";
      resp.data.log();
      return (null, Exception(errMsg));
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<String?> sendEmailVerification({required String email}) {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<(Session?, Exception?)> signIn({
    required String email,
    required String password,
    bool? rememberMe,
  }) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'remember_me': rememberMe
      };

      final resp = await _dio.post("$_baseURL/v1/auth/sign-in", data: data);

      // ! arrglar os manejos de errores no me convencen
      // * Cambiar si es == 200
      if (resp.statusCode != 200) {
        final String errorMessage =
            resp.data['message'] ?? 'err-message-not-found';
        resp.data.toString().log();
        return (null, Exception(errorMessage));
      }
      resp.data.toString().log();

      final session = Session.fromJson(resp.data);
      return (session, null);
      // ! Atrapar Dio excep o error general Exception
    } on DioException catch (e) {
      String errMsg = "Err connection";
      // si existe respuesta del servidor, intenta extraer  el mensaje del body
      /* aqui ya es dio expe 
      if (e.response != null) { 
        errMsg = e.response!.data['message'] ??
            "Error desconocido del servidor - no message body";
      } else */
      if (e.type == DioExceptionType.connectionTimeout) {
        errMsg = "Tiempo de connección agotado";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errMsg = "Tiempo de espera agotado al recibir datos";
      } else if (e.type == DioExceptionType.badResponse) {
        errMsg = "Respuesta incorrecta del servidor";
      } else if (e.type == DioExceptionType.unknown) {
        errMsg = "Error inesperado";
      }
      return (null, Exception(errMsg + e.toString()));
    }
  }

  // ! en on DioException catch (e), llegará el 'message' del error  o desde try
  // ! reescribir el manejo de errores
  @override
  Future<(Session?, String?)> googleSignIn({required String tokenId}) async {
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
        resp.data.toString().log();
        return (null, errorMessage);
      }
      resp.toString().log();
      final session = Session.fromJson(resp.data);
      return (
        session,
        null
      ); // * si genera error ponerlo dentro de try catch arriba
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

//! manejar  todos los try catch
  @override
  Future<Exception?> signOut({required String refreshToken}) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentUser
  Future<Session?> get currentUser async {
    // * Flujo
    // * 1. Al iniciar la app, Firebase carga el usuario autenticado desde el Local Storage / IndexedDB del dispositivo.
    // * 2. Si el usuario tiene una sesión activa (token JWT válido en caché), devuelve el usuario inmediatamente.
    // * 3. Si no hay sesión, devuelve null.
    // ? el bcken debe retornar el tiempo de expiracion? o sacarlo desde jwt
    // * 4. Si el token ha expirado, intenta renovarlo automáticamente con el refresh token.

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //final String? token = prefs
    return null;
  }
  
  @override
  Future<Exception?> sendForgotPassword({required String email}) {
    throw UnimplementedError();
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