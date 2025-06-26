import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ! verificar cuáles necesitan try catch
// * como controlar que mi session con la de google este bien
// * por que no puede iniciar sesion dos veces en google
// * en mi backend debería validarlo
// * y como se convina con el auth changes
// ! como saber todos los que se usa try catch
class GoogleSignInService {
  late final GoogleSignIn _googleSignIn;

  GoogleSignInService() {
    final clientID = dotenv.env['GOOGLE_CLIENT_ID'];
    if (clientID == null || clientID == "") {
      throw Exception("GoogleClientID is null");
    }
    //clientID.toString().log();
    _googleSignIn = GoogleSignIn(
      clientId: clientID,
      scopes: ['openid', 'email', 'profile'],
      //'https://www.googleapis.com/auth/userinfo.profile'
    );
  }

  Future<(String?, String?, String?)> signIn() async {
    try {
      //final account = _googleSignInService.signIn().catchError(onError);
      final account = await _googleSignIn.signIn();
      //account.toString().log();
      if (account == null) {
        //'Sign in screen - signIn: user is null'.log();
        return (null, null, "Sign in screen - signIn: account is null");
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null) {
        //'Sign in screen - signIn: idToken us null'.log();
        return (null, null, "Sign in screen - signIn: idToken us null");
      }

      // ? como manejar el acces token ?
      final accesToken = auth.accessToken;
      if (accesToken == null) {
        //'Sign in screen - signIn: access token is null'.log();
        return (null, null, "Sign in screen - signIn: access token is null");
        // ? no deverpia ser throw para atrapar con el catch?
      }
      return (idToken, accesToken, null);
    } catch (e) {
      return (null, null, e.toString());
    }
  }

  // ! ver si generar errores para usar try catch, y que retornan
  Future<String?> signOut() async {
    try {
      await _googleSignIn.signOut();
      return null;
    } catch (e) {
      return "GoogleSignInService - signOut err ${e.toString()}";
    }
  }

  // serviría para delete account, como manejarlo desde el backend crear copia de sustados eliminar solo el id del usario?
  // para que el usuario elimina completamente su cuenta en la app
  Future disconnect() => _googleSignIn.disconnect();

  Future<bool> isSignIn() async => await _googleSignIn.isSignedIn();

  StreamSubscription<GoogleSignInAccount?> googleSignInSuscription() {
    return _googleSignIn.onCurrentUserChanged.listen((account) async {
      if (account == null) {
        //"GoogleSignInService account is null".log();
      } else {
        //"****************** user google *****************".log();
        final auth = await account.authentication;
        //account.email.log();
        //auth.idToken!.log();
        //"****************** user google *****************".log();
      }
    });
  }

  // parecido al sign in normal
  Future<GoogleSignInAccount?> signInSilently() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account == null) {
        throw Exception("silence account is null");
      }

      final auth = await account.authentication;

      //print(account.email);
      //print(auth.idToken);
      throw Exception("revisar");
    } catch (e) {
      //print(" ********************* ${e.toString()}");
    }
    return _googleSignIn.signInSilently();
  }

  // ejecutar cuando esta logueado
  Future clearAuthCache() {
    return _googleSignIn.currentUser!.clearAuthCache();
  }
  // que es el clientID

  /* Future clearAuth() {
    return _googleSignIn.clientId;
  } */
}
