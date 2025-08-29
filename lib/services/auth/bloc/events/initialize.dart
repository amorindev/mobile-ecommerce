import 'package:bloc/bloc.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/local-storage/session_secure_storage.dart';

// * el exipresin me parece que es del refreshtoken entonces validar que no expre
// * si expiro entonces sign in cualquier otro error de /refresh-token retornar al
// * sign in page
// ? el bcken debe retornar el tiempo de expiracion? o sacarlo desde jwt
// * 4. Si el token ha expirado, intenta renovarlo automáticamente con el refresh token.

Future<void> initializeBlocEvent(
  AuthEventInitialize event,
  Emitter<AuthState> emit,
  AuthGateway provider,
) async {
  // * Get refreshtoken fron local storage
  final rToken = await SessionSecureStorage.getRefreshToken();

  if (rToken == null) {
    // await SessionSecureStorage.clearTokens(); me parece no necesarion si es nulo
    emit(const AuthStateSignedOut(exception: null, isLoading: false));
    return;
  }

  final (resp, respErr) = await provider.refreshToken(refreshToken: rToken);
  if (respErr != null) {
    // AccessTokenExpiredAuthExeption inclueye
    emit(const AuthStateSignedOut(exception: null, isLoading: false));
    return;
  }

  if (resp == null) {
    emit(const AuthStateSignedOut(exception: null, isLoading: false));
    return;
  }

  // * Guardar el refreshtoken en localstorage
  SessionSecureStorage.saveRefreshToken(resp.session!.refreshToken);

  // * Si todo sale bien sign in
  // ! no valla ser que me redireccione sin pasar por el onboarding
  emit(AuthStateSignedIn(
    authResponse: resp,
    isLoading: false,
  ));
}
