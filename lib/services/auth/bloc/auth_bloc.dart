import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/auth/bloc/events/initialize.dart';
import 'package:flu_go_jwt/services/auth/bloc/events/sign_up_otp.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/local-storage/session_secure_storage.dart';
import 'package:flu_go_jwt/services/auth/domain/domainv2.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthGateway provider)
      : super(
          const AuthStateUninitialized(),
        ) {
    on<AuthEventInitialize>((event, emit) async {
      return initializeBlocEvent(event, emit, provider);
    });

    // ! para los otros módulos necesitaremos el refresh token y e accesstoken
    // ! nos comunicamos con el bloc para el accestoken, y para el regreshtoken el AuthEventRefreshToken
    // ! o simplmente el gateway pero recuera refreshtoken tiene un proceso
    // ver que datos se puede scar de stasdo
    // por que en el esta principal no se pone la session

    // * iniciar session con usuarios no verificados para ver si aparece la pantalla
    // * de verificación

    // ! no me parece un evento me parece una funcion de api que debe llmarse
    // ! desde el bloc que lo requira

    on<AuthEventEnableMfaSms>((event, emit) async {
      // la idea de esto es pasar el token
      //print("------------------------------");
      //print(state);
      //print("------------------------------");
      if (state is AuthStateSignedIn) {
        final currentState = state as AuthStateSignedIn;

        // puedo hacer dos cosas decir si el otp cambia no cambies de pantalla
        // solo si cambia session o user ver y usamos copiwith
        // en verda solo afectar al otp id
        // ? guardar el estado

        emit(currentState.copyWith(
          twoFaData: const TwoFaData(
            otpId: null,
            exception: null,
            isVerifying: true,
          ),
        ));

        final (resp, respErr) = await provider.enableMfaSms(
          accessToken: event.accessToken,
          phoneId: event.phoneId,
        );

        emit(currentState.copyWith(
          twoFaData: const TwoFaData(
            otpId: null,
            exception: null,
            isVerifying: false,
          ),
        ));

        if (respErr != null) {
          emit(currentState.copyWith(
            twoFaData: TwoFaData(
              exception: respErr,
              isVerifying: false,
            ),
          ));
          return;
        }
        emit(currentState.copyWith(
          twoFaData: TwoFaData(
            otpId: resp,
            isSuccess: true,
          ),
        ));
        // * otro podemos defrente pasarle
        /* emit(AuthStateEnableTwoFaSms(
    isLoading: false,
    otpId: otpId,
    exception: exception,
  )); */
      }
      //print(state);
      // ! esto siempre se imprimiira ahh
      //print("is not signed innnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    });

    on<AuthEventRefreshToken>((event, emit) async {
      //! si la session el null access y refresh token mostrar sign in
      // * en sign out si la respuesta es que el token expiro deveria usar /refresh-token handler
      // o simplemente eliminar lo que queda en file storage y enviarlo al login
      // * En que funciones usaré esto en get posts

      /* final session = await SessionSecureStorage.getTokens();

      if (session.refreshToken == null) {
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        return;
      }

      final (resp, respErr) = await provider.refreshToken(
        refreshToken: session.refreshToken!,
      );
      // me parece qe aca no necesitamos loading por que será uado por otros eventos de eeste bloc
      if (respErr != null) {
        // limpiar loca storage
        await SessionSecureStorage.clearTokens();
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
      }

      await SessionSecureStorage.saveTokens(
        resp!.accessToken,
        resp.refreshToken,
      );

      // ! la pregunta del dia dundo separa authResp o user de session como supabase
      // ! authresp tiene los dos pero lo podemos separar a session y user o auth
      // ! ver ver ver so auth no tiene provider como respuesta entonces solo quedarái user
      // ! ver si en verda se va usar provider como campo e authRespo y queda solo user

      if (state is AuthStateSignedIn) {
        final authState = state as AuthStateSignedIn;
        // ! ver que estaodo tendra auth2 me parece que será nulo
        final auth2 = authState.authResponse!.copyWith(
          session: Session(
            accessToken: resp.accessToken,
            refreshToken: resp.refreshToken,
            // ! esto falta implmentar
            expiresIn: 123,
          ),
        );
        emit(AuthStateSignedIn(
          authResponse: auth2,
          isLoading: false,
        ));
        return; // por si mas aelante agreo algo abajo
      } */
      //debugPrint("bloc refresh !!!!!!!!!!");
    });

    on<AuthEventResendVerifyEmailOtp>((event, emit) async {
      if (state is AuthStateNeedsVerification) {
        final currentState = state as AuthStateNeedsVerification;
        emit(currentState.copyWith(
          //no disponible refactorizar tambien el listener
          exp: Exception("no disponible"),
        ));
        return;
      }

      // si es resend email tenemo que
      emit(const AuthStateSendEmailVerificationOTP(
        exception: null,
        isLoading: true,
      ));
      // si es desde register deberiamos tener el email desde authResponseBloc
      // si es desde sign in
      // ! asegirar el authUser o solo user flujo dentro de toso el bloc

      //if (state is AuthStateNeedsVerification) {
      //final authState = state as AuthStateNeedsVerification;

      // * que el backend retorne el id y actualizar el authBloc = user.otpid = 1
      // si viene del sign in o register el authResp no debe ser nulo
      final respErr = await provider.resendVerifyEmailOtp(
        email: state.authResponse!.user.email,
      );
      // mejor aca para quitar para ambos emit el loading
      emit(const AuthStateSendEmailVerificationOTP(
        exception: null,
        isLoading: false,
      ));
      if (respErr == null) {
        emit(AuthStateSendEmailVerificationOTP(
          exception: respErr,
          isLoading: false,
        ));

        return;
      }
      // agregar a AuthStateSendEmailVerificationOTP mensaje que funciono o un bool
      // y en la ui ver internalizacion o usar name-des asi para la parte infreestrucutra
      // me parece que solo es necesario manejar el error
      //emit(AuthStateSendEmailVerificationOTP(exception: null, isLoading: true,));
      //}
    });

    on<AuthEventResendVerifyEnableMfaSmsOtp>((event, emit) {});

    on<AuthEventResendVerifyMfaSmsOtp>((event, emit) {});

    on<AuthEventSignIn>((event, emit) async {
      emit(const AuthStateSignedOut(
        exception: null,
        isLoading: true,
      ));

      final email = event.email;
      final password = event.password;
      final rememberMe = event.rememberMe;

      final (resp, respErr) = await provider.signIn(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
      if (respErr != null) {
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        // hay dos eventos asincronos hacer una capa mas de servicio?
        emit(AuthStateSignedOut(exception: respErr, isLoading: false));
        return;
      }

      if (!resp!.user.emailVerified) {
        emit(const AuthStateSignedOut(
          exception: null,
          isLoading: false,
        ));
        emit(AuthStateNeedsVerification(
          navigate: true,
          authResponse: resp,
          isLoading: false,
        ));
        return;
      }

      // * Dos formas se puede hacer tipo un estado donde
      // * creamos authStateEnableTeo Fa y suapantalla
      // * Pero no me parece un estado asi que cual es mejor encuanto a seguidad
      // * el otro es tener un listener si todo ha salido ok verificar si se habilito
      // * two fa y navegar
      // * lo mismo para para verify email
      // * tambien depende de si al registrar tenemos la session lo ideal seria al
      // *  registrar no tener lasession si no al verificar
      // !ver cual usar por que ademas si hado desde el listener el usuario
      // ! puede retornar sin cerrar la app si es como el email
      // ! seria camviar de estado
      if (resp.user.is2FAEnabled) {
        // tenemos casos por ejemplo si esta activo MFA o TWO fa entonces
        // la session se seguira retornando en el sign in o cuando termine
        // two fa el isguiente paso recien retornamos
        emit(const AuthStateSignedOut(
          exception: null,
          isLoading: false,
        ));
        emit(AuthStateNeedsVerificationTwa(
            otpId: resp.otpId!, email: resp.user.email, isLoading: false, navigate: true));
        return;
      }

      // ! los campos son nuleables por que estamos usando un sola clase para sign in sign-up-verify-otp
      // ! sign-up, pero sabemos que el backend siempre nos devolvera ese valor
      // * save userCredentials  in local storage
      // verificar
      //await AuthLocalStorage.saveSession(session!);
      // ?retornar el error
      //print("**********************************p8");

      // ! Depende si esta  activo el mfa
      await SessionSecureStorage.saveRefreshToken(
        resp.session!.refreshToken,
      );
      //print("**********************************p9");

      emit(const AuthStateSignedOut(
        exception: null,
        isLoading: false,
      ));
      //print("**********************************p10");

      emit(AuthStateSignedIn(
        authResponse: resp,
        isLoading: false,
      ));
    });

    on<AuthEventSignOut>((event, emit) async {
      // TODO ad loading
      // ! cuando traer la session de localstorage y cuando de sesionBloc
      // ? Loading ? si agreagar
      // * en quee casos verifico ambos token y cuando uno solo

      // de momento lo sacare de local storage, ver el fujo de la varible sessionBloc
      final refreshtoken = await SessionSecureStorage.getRefreshToken();
      if (refreshtoken == null) {
        await SessionSecureStorage.clearRefreshToken();
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        return;
      }

      // rebocar el token con el uuid? retar y eliminar de
      // preference 
      final respErr = await provider.signOut(refreshToken: refreshtoken);
      //print("-----------------------------sign-out");

      if (respErr != null) {
        // * se manejará según el tipo de error
        // ? que tipo de errores me mantienen dentro de la session, mostrando el eror
        // ? y que pasa con el usario solo mostrarle el error y mantenerlo ahi
        // ? o sol es un aviso

        // * si es solo aviso , debemos crear otro estado, o agregar error o aviso a
        // * AuthStateSignedIn
        // ! ver ambos flujos de la variables de bloc
        //emit(AuthStateSignedIn(authResponse: authResponseBloc!, isLoading: true));

        // * De momento
        /* emit(AuthStateSignedIn(
            authResponse: authResponseBloc!,
            isLoading: false,
            exception: respErr));
 */
        // ! cada deberia ser no setear a nul por que se borraria, entonces, ver que acciones hacer
        // ! antes y despues que el usuario hizo click en ok por que mostraremos mensaje si no tiene
        // ! internet  los de mas lo pasaremos por alto
        // ! hacer los diagrams de flujo del profe, antes de eso probar usarioos que aun no verifican su
        // ! cuenta llevarlos a verify account , pegar todo en el doc
        await SessionSecureStorage.clearRefreshToken();

        // * si queremos notificar que no tiene conexion a internet
        // * agregar notificacion campo final Exception? o String? para mostrarle
        // * que no tiene conexion a internet
        //emit(const AuthStateSignedIn(authResponse: authResponse, isLoading: isLoading));
        //print("-----------------------------sign-out10");
        // * limpiar  persistencia local

        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        return;
        // ? debería ser login con un error no signout con error
        // a no ser que se cierre luego de cerrarse aparesca el error
        // pero si se mantiene en la pantalla mejor es sign in con error
        //emit(AuthStateSignedOut(exception: respExp, isLoading: false));
      }

      // verificar si se debe manejar aguna excepion o si el usario no existe
      // en este punto deberíamos tener la session
      // ? debería retornar un error?
      // eliminar lo que quede el access_token
      await SessionSecureStorage.clearRefreshToken();
      //print("-----------------------------sign-out20");
      emit(const AuthStateSignedOut(exception: null, isLoading: false));

      // la session va en el state global y por que el loading si?
      //final respErr = await provider.signOut(refreshToken: state.session.refreshToken);
      // * verificar si el signout de firebase genera error
    });

    // * esto era para probar separar en la carpeta envents
    /* on<AuthEventSignOut>(
      (event, emit) => signInBlocEvent(
        event,
        emit,
        provider,
      ),
    ); */

    on<AuthEventSignUp>((event, emit) async {
      return signUpBlocEvent(event, emit, provider);
    });

    on<AuthEventVerifyEmailOtp>((event, emit) async {
      if (state is AuthStateNeedsVerification) {
        final currentState = state as AuthStateNeedsVerification;
        // ! si hace un resend email el otpID va ser distinto ver
        // ! sendEmailverificatioOTP de momento sencillo sin
        // * necesito el otpID, y el email
        // * si vas a modificar el authResp para cambiar el otpID usa copywith
        emit(currentState.copyWith(isLoading: true));
        // ! hacer este tipo de validaciones en otros events
        //print("estoy aquiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii3");
        //print("otp code ${event.otpCode}");
        // verifique que no sea nulo y el otp si me deb llegar en este punto
        // * _TypeError (Null check operator used on a null value)
        // ! afecta aqui si retornamos la session en despes del sign up
        final (authResp, respErr) = await provider.verifyEmailOtp(
          otpId: currentState.authResponse!.otpId!,
          otpCode: event.otpCode,
          email: currentState.authResponse!.user.email,
        );
        //print("estoy aquiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii4");

        emit(currentState.copyWith(isLoading: false));
        // tenemos que manejar otp invalid
        if (respErr != null) {
          //print("the error ${respErr.toString()}");
          //print("estoy aquiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii5");
          //print(state);
          emit(currentState.copyWith(exp: respErr));
          return;
        }
        //print("estoy aquiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii6");

        // * verifico su correo e inicio session
        // * save tokens - veria llegar el token o revisar si llega y redireccionar ono se
        // ! este es asyncrono entonces el loading de carga iria dentro del if
        // ! y otro aqui para qui para mostrar el loading correactamente
        await SessionSecureStorage.saveRefreshToken(
          authResp!.session!.refreshToken,
        );
        //print("estoy aquiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii7");

        // * de momento el access token y refresh estan dentro del authResp ver cuando separalo
        // * o cómo manejarlo
        emit(AuthStateSignedIn(
          authResponse: authResp,
          isLoading: false,
        ));

        // * authResponseBloc = authResp;
        /* sessionBloc = Session(
        accessToken: authResp!.accessToken,
        refreshToken: authResp.refreshToken,
      ); */
        //}

        //print("bloc !!!!!!!!!!");
        // ! ver que se puede hacer redireccionar ?
        //emit(const AuthStateSignUpVerifyOtp(exception: null, isLoading: false));
        //emit(AuthStateSignedIn(authResponse: authResp, isLoading: false));
      }
    });

    on<AuthEventVerifyEnableMfaSmsOtp>((event, emit) async {
      if (state is AuthStateSignedIn) {
        final currentState = state as AuthStateSignedIn;
        // * Me parece que no pasa nada si asigno el auth response que me retorna
        // * la api, y hago un AuthStateSignedIn
        // * Puede pasar dos cosas depende si es signed in me parece que se mantendra en la pantalla
        // * pero ahora como estamos emitiendo sign in pero pasando de otro estado
        // * me parece que cambiaría la pantalla ver por ejemplo aqui emitiremos un estado diferente
        //print("AuthEventEnableTwoFaSmsVerifyOtp %%%%%%%%%%%%%%%%%%%%%%%%%%%");
        //print("AuthEventEnableTwoFaSmsVerifyOtp: ${currentState.verifyOtpStatus}");

        //print("AuthEventEnableTwoFaSmsVerifyOtp %%%%%%%%%%%%%%%%%%%%%%%%%%%");

        emit(currentState.copyWith(
          verifyOtpStatus: const VerifyOtpStatus(
            isLoading: true,
          ),
        ));

        // validaciones normales o entiempo real o separarlo en troo bloc mas sencillo o cubit

        // ! obtener el otpId pasando lo  o hacer
        // ! if state is AuthStateEnableTwoFaSms y de ahi traer el otpId lo mismo para los demas
        //print("AuthEventEnableTwoFaSmsVerifyOtp &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&1");
        final (resp, respErr) = await provider.verifyEnableMfaSmsOtp(
          //accessToken: state.authResponse!.session!.accessToken, // para otros DDD como seria
          accessToken: event.accessToken, // para otros DDD como seria
          otpId: event.otpId,
          otpCode: event.otpCode,
        );
        //print("AuthEventEnableTwoFaSmsVerifyOtp $resp");
        //print("AuthEventEnableTwoFaSmsVerifyOtp $respErr");
        //print("AuthEventEnableTwoFaSmsVerifyOtp &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&100");

        //agrgar resp al AuthState
        emit(currentState.copyWith(
            verifyOtpStatus: const VerifyOtpStatus(
          isLoading: false,
        )));
        //print("AuthEventEnableTwoFaSmsVerifyOtp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        //print(state);
        //print("AuthEventEnableTwoFaSmsVerifyOtp %%%%%%%%%%%%%%%%%%%%%%%%%%%");
        if (respErr != null) {
          //print(respErr);
          emit(currentState.copyWith(
            verifyOtpStatus: VerifyOtpStatus(
              exception: respErr,
            ),
          ));
          //print("AuthEventEnableTwoFaSmsVerifyOtp %%%%%%%%%%%%%%%%%%%%%%%%%%%");
          //print(respErr);
          //print(state);
          //print("AuthEventEnableTwoFaSmsVerifyOtp %%%%%%%%%%%%%%%%%%%%%%%%%%%");
          //print("AuthEventEnableTwoFaSmsVerifyOtp &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&101");
          return;
        }
        //print("AuthEventEnableTwoFaSmsVerifyOtp &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&100000");

        /* emit( AuthStateEnableTwoFaSmsVerifyOtp(
        authResponse: null,
        exception: null,
        isLoading: false,
      )); */
        // que es lo que pasa si al terminar la operacion con exito
        // debemos estar signed in por que algunos lo requieren
        // dos formas copiw9ith al estado o solo al user
        //emit(AuthStateSignedIn(authResponse: saveState, isLoading: false));
        //   final updateAuthResp = currentState.authResponse!.copyWith(user: resp);
        //  emit(currentState.copyWith(authResponse: updateAuthResp));

        // ! es mejo rtener la session el auth response en la clase abstrcta
        // ! si despues de este evento el usuario vuelve a iniciar session no abría problema
        // ! pero que pasa si el suaurio se mantien logueado la tendrpiamos
        // ! dos Authrresponse no se si con los mismos datos
        emit(currentState.copyWith(
          verifyOtpStatus: const VerifyOtpStatus(
            isSuccess: true,
          ),
        ));
      }
    });

    on<AuthEventVerifyMfaSmsOtp>((event, emit) async {
      if (state is AuthStateNeedsVerificationTwa) {
        final currentState = state as AuthStateNeedsVerificationTwa;
        emit(currentState.copyWith(
            twoFaSmsVerifyOtp: const TwoFaSmsVerifyOtp(
          isLoading: true,
        )));
        //print("initttttttttttttttttt1");
        final (resp, respErr) = await provider.verifyMfaSmsOtp(
          otpId: currentState.otpId,
          otpCode: event.otpCode,
        );
        //print(resp);
        //print(respErr);
        //print("initttttttttttttttttt2");

        emit(currentState.copyWith(
          twoFaSmsVerifyOtp: const TwoFaSmsVerifyOtp(isLoading: false),
        ));
        if (respErr != null) {
          //print("initttttttttttttttttt3");

          emit(currentState.copyWith(
            twoFaSmsVerifyOtp: TwoFaSmsVerifyOtp(
              exp: respErr,
            ),
          ));

          return;
        }
        //print("initttttttttttttttttt4");

        await SessionSecureStorage.saveRefreshToken(
          resp!.session!.refreshToken,
        );
        //print("initttttttttttttttttt5");

        emit(AuthStateSignedIn(
          authResponse: resp,
          isLoading: false,
        ));
        //print("initttttttttttttttttt6");
      }
      //print("erororororororor");
    });
  }
}
