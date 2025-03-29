import 'package:bloc/bloc.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';

Future<void> signInBlocEvent(
  AuthEventSignOut event,
  Emitter<AuthState> emit,
  AuthGateway provider,
) async {
  final respErr = await provider.signOut(
    refreshToken: "no-tengo-el-refresh-token-authbloc",
  );
  if (respErr != null) {
    // ? debería ser login con un error no signout con error
    // a no ser que se cierre luego de cerrarse aparesca el error
    // pero si se mantiene en la pantalla mejor es sign in con error
    emit(AuthStateSignedOut(exception: respErr, isLoading: false));
  }

  emit(const AuthStateSignedOut(exception: null, isLoading: false));

}
/* FutureOr<void> Function(AuthEventInitialize event, Emitter<AuthState> emit) handler(){
  
}
 */