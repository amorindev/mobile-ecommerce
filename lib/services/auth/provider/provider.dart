import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:flu_go_jwt/services/auth/services/google_sign_in_service.dart';
import 'package:flu_go_jwt/services/auth/use_case/use_case.dart';
import 'package:flu_go_jwt/services/auth/use_cases/api/api_dio_gateway.dart';
//import 'package:flu_go_jwt/services/auth/use_cases/grpc/grpc_gateway.dart';
import 'package:flutter/material.dart';

// ! -------------------------------------------
// ? Cuando usar return ?, pr que siga con la ejecuion en el provider me parece o en ls funciones de la pantalla
// ? o lguna validcion o cundo ocurre un erorr return;
// ! -------------------------------------------

// * En que sediferencin el current user y push  notificactions
// * mobile y backend

// * En backend que retorne session y user peradado, igual a firebase? como manejarlo
// * creamos la se

// * ErrSignIn o SignInErr
// * ver providers y streams para el branchio lo mismo para bloc
// !verificar como se relacion el backend con google y dhared preferences
class AuthProvider extends ChangeNotifier {
  // weincode lo hace desde providers.dart
  final UseCase _gateway = UseCase(gateway: ApiDioGateway());
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  //final UseCase _gateway2 = UseCase(gateway: GrpcGateway());

  // * -----------------------------
  
  // * -----------------------------



  // * Globals - Sign in
  String name = "fernan";
  Session? session; // solo para sign in no pra sign up

  // * como estamos retornando el provider en sign up me parece no necesario
  // * lo dejamos y usamos solo los datos del user
  User? userSignUp;

  // * Sign up
  bool isLoadingSignUp = false;
  String? errSignUp;

  Future signUp(String email, String password, String confirmPassword) async {
    isLoadingSignUp = true;
    final (userResp, errResp) = await _gateway.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    userSignUp = userResp;
    errSignUp = errResp.toString();
    isLoadingSignUp = false;
    notifyListeners();
  }

  // * Sign in
  bool isLoadingSignIn = false;
  String? signInErr;

  Future signIn(String email, String password, bool? rememberMe) async {
    isLoadingSignIn = true;
    final (sessionResp, errResp) = await _gateway.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
    session = sessionResp;
    signInErr = errResp.toString();

    // * Guardar el access token y refresh token
    isLoadingSignIn = false;
    notifyListeners();
  }

  // User
  bool isLoggedIn = false;
  Future userIsLoggedIn() async {
    final resp = await _googleSignInService.isSignIn();
    isLoggedIn = resp;
  }

  // * Sign out
  // ! es dependiendo si es email password u otr
  // ! isLoadingSignUp2?
  bool isLoadingSignUp2 = false;

  // Google sign out
  bool isLoadingGoogleSignOut = false;
  String? googleSignOutErr;
  // * pue ser si no se completo el sign out con exito elcron job ya lo elimina
  // * si no encuentra la sesion a eliminar solo retornamos que fue exitoso
  // * y no dejamos al usuario en estático
  // * y como combinar con shared preferences si no se elimina correctamente
  // * podemos update tokens por si no se elimina para que no cause error
  // * desconectar si la sessión ya no es válida - sino mantener con inicio de sesión
  // * si ocurre un error al eliminar el token me parece no necesario mantener al usuario loguado
  // * segun el tipo de error

  Future googleSingOut() async {
    isLoadingGoogleSignOut = true;
    // * sign out google
    final googleSignOutErrResp = await _googleSignInService.signOut();
    googleSignOutErr = googleSignOutErrResp;
    // * sign out backend para eliminar el token
    // ? sign out con google se devería crear un handler por cada proveedor o uno
    // ? para sign out email password, y otra para proveedores

    // * get shared preference token

    // * Sign out request to the backend, para eliminar la session, invalidar el token del backend
    // * enviar el access token o refresh token, generalmente refresh
    /* final signOutErr = await _gateway.signOut(refreshToken: "");
    googleSignOutErr = signOutErr; */


    // * Si usas refresh tokens, elimínalo de la base de datos.
    // * Si usas sesiones en memoria o Redis, remuévela.
    // * Si usas access tokens sin estado (JWT), simplemente informa al cliente que cierre sesión.

    // * remove tokens shared preferences
    isLoadingGoogleSignOut = false;
    notifyListeners();
  }

  // * Google sign in
  bool isLoadingGoogleSignIn = false;
  String? googleSignInErr;

  // ? como manejar los throw
  Future googleSignIn() async {
    isLoadingGoogleSignIn = true;

    final (idToken, accessToken, err) = await _googleSignInService.signIn();
    signInErr = err;

    if (idToken == null) {
      signInErr = "AuthProvider idtoken is null";
      return;
    }
    "id token --------------".log();
    idToken.toString().log();
    "id token --------------".log();

    final (sessionResp, errResp) = await _gateway.googleSignIn(
      tokenId: idToken,
    );
    session = sessionResp;
    signInErr = errResp;

    // * shared precerence guardar los tokens
    isLoadingGoogleSignIn = false;
    notifyListeners();
  }

  // * Sign in with provider teníamos el caso donde no podemos iniciar sesión dos veces, como se si inicie sesión?
  // * crear una variable google session y apple session y validar si es nulo
  // * o llamar nuevamente a signIn y ver que responde

  // * Send email verification
  bool isLoadingSendEmailVerification = false;
  String? errSendEmaiVerifiation;
  //* Send Emil verification
  Future sendEmailVerification(String email) async {}
}
