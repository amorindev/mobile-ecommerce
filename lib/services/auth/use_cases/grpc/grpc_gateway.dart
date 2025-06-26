/* import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/grpc/gen/auth_srv.pbgrpc.dart';
import 'package:flu_go_jwt/services/auth/grpc/gen/sign_in.pb.dart';
import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:flu_go_jwt/services/auth/services/local-storage/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc.dart';

class GrpcGateway implements AuthGateway {
  late final ClientChannel _channel;
  late final AuthServiceClient _client;

  GrpcGateway() {
    // solo la url y con split separar
    //final String url = dotenv.env['GRPC_URL'] ?? "GRPC_URL not set";
    final String? url = dotenv.env['GRPC_URL'];
    if (url == null || url == "") {
      throw Exception("environment variable GRPC_URL is not set");
    }
    url.toString().log();

    final List<String> urlSplited = url.split(":");
    if (urlSplited.length != 2) {
      throw Exception("host length != 2");
    }
    final String host = urlSplited[0];
    final int? port = int.tryParse(urlSplited[1]);
    if (port == null) {
      throw Exception("port isn't int type");
    }

    // si hay mas de dos elementos
    //    final int port = parts.length > 1 ? int.tryParse(parts[1]) ?? 50051 : 50051;

    _channel = ClientChannel(
      host,
      port: port,
      // ? Como cambiar a segure para producción ?
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _client = AuthServiceClient(_channel);
  }

  // método para acceder al cliente // deberia ser declarado aqui o en el provider u otro?
  // _ pra privados
  AuthServiceClient get client => _client;

  // método para cerrar el canal
  Future<void> close() async {
    await _channel.shutdown();
  }

  @override
  Future<(User?, Exception?)> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    /* try {
      final req = 
    } catch (e) {
      
    } */

    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, Exception?)> signIn({
    required String email,
    required String password,
    bool? rememberMe,
  }) async {
    try {
      // ! me puso todos los campos como opcionales revisar el .proto
      // ! en el bckend tambien
      final req = SignInRequestMessage(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
      final resp = await _client.signIn(req);

     /*  List<Role> roles = [];
      // * Roles
      for (var rolePb in resp.user.roles) {
        final role = Role(id: rolePb.id, name: rolePb.name);
        roles.add(role);
      } */

      // * Fechas
      final DateTime ca = resp.user.createdAt.toDateTime(toLocal: true);
      final DateTime ua = resp.user.updatedAt.toDateTime(toLocal: true);

      final session = AuthResponse(
        provider: resp.provider,
        accessToken: resp.accessToken,
        refreshToken: resp.refreshToken,
        user: User(
          id: resp.user.id,
          email: resp.user.email,
          emailVerified: resp.user.emailVerified,
          //roles: roles,
          createdAt: ca,
          updatedAt: ua,
        ),
      );

      //print(session);
      return (session, null);
    } catch (e) {
      return (null, Exception(e.toString()));
    }
  }

  @override
  Future<Exception?> signOut({required String refreshToken}) {
    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, String?)> googleSignIn({required String tokenId}) {
    throw UnimplementedError();
  }

  // con toknen ? o sin token como mnejar si es confirm passwrod o enviar email pra cambiar contraseña
  // ! verificar la cantidad de request por usurio en  el backend pra todos
  @override
  Future<Exception?> sendEmailVerification({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<Exception?> sendForgotPassword({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, Exception?)> getUser({required String accessToken}) {
    throw UnimplementedError();
  }

  @override
  Future<(Session?, Exception)> refreshToken({
    required String refreshToken,
  }) {
    throw UnimplementedError();
  }

  @override
  Future sendEmailVerificarionOTP({required email}) {
    throw UnimplementedError();
  }

  @override
  Future<(AuthResponse?, Exception?)> signUpVerifyOtp(
      {required String otpId, required String otpCode, required String email}) {
    throw UnimplementedError();
  }
}
 */