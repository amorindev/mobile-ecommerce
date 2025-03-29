import 'package:flu_go_jwt/services/auth/models/model.dart';

// supabase  y firebase tienen sign up anonimus o mas cosas al sign up puedes agregarle
// {} parámetros no requeridos como phone y otros
// * Ver en que casos usar objetos como create Signup junto UserCreateRequest
// ? Retornar Exception o el mi AuthException que engloba todas las exceptiones ?

abstract class AuthGateway {
  Future<(User?, Exception?)> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<(Session?, Exception?)> signIn({
    required String email,
    required String password,
    bool? rememberMe,
  });

  Future<(Session?, String?)> googleSignIn({required String tokenId});

  // * eliminar la session mediante el id del refreshtoken
  // ? deberia retornr un error firebse si lo hace
  // ? pero que error cuando invalido el session o jwt del backend pero eso con un cron job se elimina
  // ? que pasa si se elimina la session y da un error al eliminar de local storage
  // * para eliminar de local storage no es necesaario que pare la ejecucuon por que cundo ingreso uno nuevo,
  // * si da error primero mero pregunto si hay data
  // * que paso seria cortante que no tenga conexion? de dio o algo asi ver
  Future<Exception?> signOut({required String refreshToken});

  Future<String?> sendEmailVerification({required String email});

  Future<Session?> get currentUser;

  Future<Exception?> sendForgotPassword({required String email});
}
