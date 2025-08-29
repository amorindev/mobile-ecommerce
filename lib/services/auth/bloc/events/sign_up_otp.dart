import 'package:bloc/bloc.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';

Future<void> signUpBlocEvent(
  AuthEventSignUp event,
  Emitter<AuthState> emit,
  AuthGateway provider,
) async {
  emit(const AuthStateRegistering(
    exception: null,
    isLoading: true,
  ));

  final email = event.email;
  final password = event.password;
  final confirmPassword = event.confirmPassword;
  final name = event.name;

  if (password != confirmPassword) {
    emit(const AuthStateRegistering(
      exception: null,
      isLoading: false,
    ));
    emit(AuthStateRegistering(
      exception: Exception('las contraseñas no coinciden'),
      isLoading: false,
    ));
    return;
  }

  if (password.length < 8) {
    emit(const AuthStateRegistering(
      exception: null,
      isLoading: false,
    ));
    emit(AuthStateRegistering(
      exception: Exception(
        'La contraseña debe tener al menos 8 caracteres.',
      ),
      isLoading: false,
    ));
    return;
  }

  if (name.trim() == "") {
    emit(const AuthStateRegistering(
      exception: null,
      isLoading: false,
    ));
    emit(AuthStateRegistering(
      exception: Exception(
        'Ingrese un nombre válido',
      ),
      isLoading: false,
    ));
    return;
  }
  final (authResp, respErr) = await provider.signUpOtp(
    email: email,
    password: password,
    confirmPassword: confirmPassword,
    name: name,
  );

  if (respErr != null) {
    emit(const AuthStateRegistering(
      exception: null,
      isLoading: false,
    ));
    emit(AuthStateRegistering(exception: respErr, isLoading: false));
    return;
  }

  // * authResponseBloc = authResp;

  // ? verificar si es nulo no deberia ser nulo si no existe un error
  // agregar el usuario al estado para enviar email de verificación
  //print(authResp);
  emit(const AuthStateRegistering(
    exception: null,
    isLoading: false,
  ));
  // ! el problema  con esto es que
  // ! no va a cumplir con la condicion principal if (state is AuthStateRegistering)
  // ! por eso no se muestra en cotala el estado cuand lo imprimes desde el listener
  // ! save19-6-2025 ahi te da ejemplos
  // ! otra forma es usndo las propiedades del user mejor seguimos en estados
  // ! luego de ver el  save chat, hay dos opciones if (state is AuthStateNeedsVerification) {
  // ! if (state is AuthStateSignedIn || state is AuthStateNeedsVerification)
  // ! se tendria que ver con el resto para que no se repita esta validacion y no
  // ! realicemos dos veces la navegacion
  emit(AuthStateNeedsVerification(
    navigate: true,
    authResponse: authResp!,
    isLoading: false,
  ));
}
