import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/local-storage/session_secure_storage.dart';
import 'package:flu_go_jwt/services/auth/models/modelv2.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/rendering.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// * se puede hacer de dos maneras dejr auth provider con todos uth google facebook
// * o separar por proveedor en cad de servicio, facebook
// * events producen states

// * todos tengan carga los que son asincronos
// * y los return correspondientes
// * respErr tenemos me parece que se puede usar el mismo como en go si en los anidados
// * ver si se puede usar la misma variable y explicar si arriba es nil se puepone que en
// * este punto es nulo

// * Ver cuando usar !, y el mounted
// * cuando emitir estados para cerrar la pantalla de loading

// *cuando se hace getUser para nosotros es
// *   AuthResponse? authResponseBloc;
// *  Session? sessionBloc;
// *  AuthResponse? authResponseSignUpBloc;

// ! cuando limpiar sessionBloc y authResponseBloc

// ? cundo realizo a current user siempre es de local storage?
// ! estas usando el current user pero el current user se saca de localstorage
// ! no del estado

// * El current user es push notification para cambiar de role o es un ses server side events

// * se puede hacer de dos maneras dejr auth provider con todos uth google facebook
// * o separar por proveedor en cad de servicio, facebook
// * events producen states

// ? cundo realizo a current user siempre es de local storage? - no es de local storage es
// ? del clase singleton que te permite escuchar cambios del usuario esta dentro de firebase supabase package

// * me aprece que firebase como supabase traen el user del singleton y haciendo peticion
// * mediante el token de local storage
// * current user es del singleton - en firebase creo tien auth changes que afecta al currentuser
// * getUser es de la api
// * en algun caso se usa localstorage  si no es asi impementarlo al inizialice

// * no quiero que al hacer current user vuela a la pantalla de home verificar que eso no suceda
// * ver como manejar los estados

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //final AuthBranchioService _srv = AuthBranchioService();
  // ? como inicializar late final o pner ? antes del _branch..
  late StreamSubscription<Map<dynamic, dynamic>> _branchIoSuscription;

  // la session etas llamando de forma estática no es mejor injectarla
  //final AuthLocalStorage _lstg = AuthLocalStorage();

  // final MyRepo repo;
  // MyBloc(this.repo)
  // * los _ son variables de instancia del bloc, si no las usas marcan warning
  // !el initialize esta asignando correctamente?
  //AuthResponse? _currentUser;
  // ? donde ponerlo para próximas request o en le AuthState
  // ? si uso  otro bloc para las otras funcionalidades como haría
  //Session? _sessionBloc;

  // * No es necesario
  //AuthResponse? authResponseBloc;
  //Session? sessionBloc;

  //AuthResponse? authResponseSignUpBloc; manejar solo 1 usar authResponseBloc
  AuthBloc(AuthGateway provider)
      // debería ser false y dentro del evento AuthEventInitialize recien true
      : super(
          const AuthStateUninitialized(isLoading: true),
        ) {
    //AuthBloc(AuthGateway provider) : super(const AuthStateUninitialized()) {
    // ? el bcken debe retornar el tiempo de expiracion? o sacarlo desde jwt
    // * 4. Si el token ha expirado, intenta renovarlo automáticamente con el refresh token.

    //_onSuscribe(); se podría ? o al final detodos on<Events> las declaraciones
    // en ves de usar ...Addd aunque no esta mas

    on<AuthEventInitialize>((event, emit) async {
      // ! ver como manejar el email verified y 2fa auth
      // practicamente estamos combinando la funcionalidad inizialice de los proveedores
      // wait provider.initiaize();

      //print("----------Initialize-------");

      // varios bloc puedente tener initialice dejar en este boc o usar el de onboarding bloc
      // y ver que no exista conflicto
      // agregar un campo mas a onbording database que es type new-user, new-feature
      // despues ver los loading
      // secure storage acepta string solamente
      /* final isNewUser = await SessionSecureStorage.isNewUser();
      if (isNewUser != "false") {
        emit(const AuthStateNewUser(
          isLoading: false,
        ));
        print("testtestestes");
        return;
      }
      print("fernan"); */

      // * Dos tipos de onboarding el de bienbenida y el de funcionalidades
      // * El de bienvenida guardar en shared preferences mostrar onboarding false
      // * Ek de funcionalidades despues de iniciar session e ir marcando como visto
      // * aunque el onboarding de bienbenida puede ser estático sohrebir no permite imagenes
      // * puede ser que varie asi que lo voy a dejar de momento dinámico

      // * Initialize --------------------------------

      final session = await SessionSecureStorage.getTokens();

      if (session.refreshToken == null) {
        // || session.accessToken == null
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        // ?final session = await SessionSecureStorage.getTokens(); o solo actualizo sin estar eliminado?
        // !--------------------------- verificar que no continue
        return;
        // !------------------------------ en los demás en cuales usarlos
      }

      // * De momento no oucrritra esto
      if (session.accessToken == null) {
        // * igualmente refresj token handler
        // get new access
        //actualiza -- llamar a rerfehsotken event y
        // * Guardar en localstorage solo el access o retorar?

        // * Si no existe error al refrescar el token sign in
        // * si exsite un error

        // ! aqui debería ser pedir con el refresh pero lo voy hacer sencilo por el tiempo
        await SessionSecureStorage.clearTokens();
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        return;
      }
      // ! no valla ser que me redireccione sin pasar por el onboarding
      emit(const AuthStateSignedOut(exception: null, isLoading: false));
      return;

      /* final (resp, respErr) = await provider.getSession(
        accessToken: session.accessToken!,
      ); */

      //if (respErr != null) {
      // si el error es accestoken expired
      // * ver la logica AccessTokenExpiredAuthExeption
      // * AuthEventRefreshToken es asyncrono y hay un chatgpt
      // * guardado de moment no se usa esta validacion
      // * guardar la session y la redireccion dentor de  AccessTokenExpiredAuthExeption
      // * usar este resp2 y no el resp de arriba
      // * no se si se udar ver si es o sino quitarlo y defrente mandarlo a siginscreeen
      /* if (respErr is AccessTokenExpiredAuthExeption) {
          // * si esta correcto actualiza la session
          // * guarda la session en local y actualiza sessionBloc

          /// * Al hacer eso el estado debe ser sign in
          add(const AuthEventRefreshToken());
          // aqui lo tokesn no son nulos
          final (resp2, respErr2) = await provider.getUser(
            accessToken: session.accessToken!,
          );

          if (respErr2 != null) {
            emit(AuthStateSignedOut(exception: respErr2, isLoading: false));
            return;
          }
          if (resp2 == null) {
            // * ver en que casos hacer esta validacion y como hacerlo
            emit(const AuthStateSignedOut(exception: null, isLoading: false));
            return;
          }
          // en este punto los tokens no son nulos
          final aUser = resp2.copyWith(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken,
          );
          emit(AuthStateSignedIn(authResponse: aUser, isLoading: false));
          return;
        } */
      // Eliminar tokens?
      //emit(const AuthStateSignedOut(exception: null, isLoading: false));
      //return;
      //}

      // * Initialize -------------------------------------------
      // * En que partes aplicar save tokens sign-in y refresh-token de momento

      // no se si es de mas
      /* if (resp == null) {
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        return;
      } */

      // Flutter full course no pone return por que usa else y else if
      /* if (resp.user.emailVerified) {
        emit(AuthStateNeedsVerification(authResponse: resp, isLoading: false));
        return;
      } */

      // aqui la session es guardada simplemente asignar el accesstoken y refresh al auth

      /* final completeAuth = resp.copyWith(
        session: Session(
          accessToken: session.accessToken!,
          refreshToken: session.refreshToken!,
          // ! ver esto de momento no lo vamos a usar
          expiresIn: 123,
        ),
      ); */

      /* emit(AuthStateSignedIn(
        authResponse: completeAuth,
        isLoading: false,
      )); */
    });

    on<AuthEventSignUp>((event, emit) async {
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
      final (authResp, respErr) = await provider.signUp(
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
    });

    on<AuthEventSignUpVerifyOtp>((event, emit) async {
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
        final (authResp, respErr) = await provider.signUpVerifyOtp(
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
        await SessionSecureStorage.saveTokens(
          authResp!.session!.accessToken,
          authResp.session!.refreshToken,
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

    // * ApiDioGateway - getUser exception type 'String' is not a subtype of type 'int' of 'index'

    on<AuthEventSendEmailVerification>((event, emit) async {
      // en este punto si es sign in o register debería tener el user
      // o usar el TextField
      // ? debería manejar el error ? - para noticficar que no se envio o solo decimos que revise
      // * verificar si en este punto authResponseBloc no es nulo
      // * register con phone email va ser nulo y usaremos ! y miraremos el flujo
      // * si me estoy registrando con email uso !
      if (state is AuthStateNeedsVerification) {
        final authState = state as AuthStateNeedsVerification;
        // si viene del sign in o register el authResp no debe ser nulo

        // en este punto aqui se debe tener el user
        await provider.sendEmailVerification(
          email: authState.authResponse!.user.email,
        );
      }
      // o emitir un mensaje o bool de exito
      emit(state);
    });

    on<AuthEventSendEmailVerificationOTP>(
      (event, emit) async {
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
        final respErr = await provider.sendEmailVerificarionOTP(
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
      },
    );

    // * En teoria si puedes llamar un evento dentro de otro ver en el caso si tienes otros blocques
    // * necesitaras el sessionBloc y AuthEventRefreshToken
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

      await SessionSecureStorage.saveTokens(
        resp.session!.accessToken,
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
        await SessionSecureStorage.clearTokens();
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        return;
      }

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
        await SessionSecureStorage.clearTokens();

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
      await SessionSecureStorage.clearTokens();
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

    on<AuthEventForgotPassword>((event, emit) async {
      emit(const AuthStateForgotPassword(
        isLoading: true,
        exception: null,
        hasSentEmail: false,
      ));
      /* if (event.email == null) {
        // * me parece que no podemos poner AuthStateForgotPassword encima de un return;
        /* emit(AuthStateForgotPassword(
          isLoading: false,
          exception: Exception("Email is required"),
          hasSentEmail: false,
        )); */

        // * aqui o debajo del if como ahora
        return;
      } */
      /* emit(const AuthStateForgotPassword(
        isLoading: true,
        exception: null,
        hasSentEmail: false,
      )); */

      final respErr = await provider.sendForgotPassword(email: event.email);
      if (respErr != null) {
        emit(
          AuthStateForgotPassword(
            isLoading: false,
            exception: respErr,
            hasSentEmail: false,
          ),
        );
      }
      emit(const AuthStateForgotPassword(
        isLoading: false,
        exception: null,
        hasSentEmail: true,
      ));
    });

    on<AuthEventNewTokenReceived>((event, emit) {
      emit(AuthStateBranchIoStateDeepLinkToken(
        token: event.token,
        isLoading: false,
      ));
    });

    /* on<BranchIoEventCancellAllSuscriptions>((event, emit) {
      onCancelSuscription(event, emit, _branchIoSuscription);
    }); */

    // close seria para cerrar todo este solo para branchio, creo que se llama desde el dispose?
    // ? cuando hacerlo para no afectar ya que branchio sale de la app
    on<CancelarSuscripcion>((event, emit) {
      _branchIoSuscription.cancel();
    });

    on<AuthEventDeleteAccount>((event, emit) async {
      // * ver cuando obtener la session los tokens de localstorage y cuando del bloc previamente cargado
      // * Manejo de errores importantes
      // ** si no existe el token en localstorage mostrar la pantalla de sign in
      // ** si no tiene autorizacion sign in en este caso no se necesario
      // ** la contraseña enviada no es correcta

      emit(const AuthStateDeleteAccount(exception: null, isLoading: true));
      final accessToken = await SessionSecureStorage.getAccessToken();

      if (accessToken == null) {
        await SessionSecureStorage.clearTokens();
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        return;
      }

      // interctuar con el servicio o api
      final respErr = await provider.deleteAccount(
        accessToken: accessToken,
        password: event.password,
      );
      //print("====================================6");

      // * Si ocurre un error muestralo de momento
      if (respErr != null) {
        //print("====================================7et");

        // * crear el cuadro  o historias de usuario
        // * no podemos forzar a salir ? no puede devolver no exite user seria catastrofico
        // * como manejar en estos casos el error
        //print("this is a err $respErr");
        emit(const AuthStateDeleteAccount(
          exception: null,
          isLoading: false,
        ));
        emit(AuthStateDeleteAccount(
          exception: respErr,
          isLoading: false,
        ));

        // de momento solo mostrar el error
        /* if (respErr is UserNotFoundAuthException || respErr is AccessTokenExpiredAuthExeption) {

        } */

        // await SessionSecureStorage.clearTokens();

        // * si queremos notificar que no tiene conexion a internet
        // * agregar notificacion campo final Exception? o String? para mostrarle
        // * que no tiene conexion a internet
        //emit(const AuthStateSignedIn(authResponse: authResponse, isLoading: isLoading)); es de otro event ver si aplica aqui

        // no se porque no funciono seguro es porque hibo excepcion
        // ver las validaciones del signout listener
        //emit( AuthStateSignedOut(exception: respErr, isLoading: false));

        //sessionBloc = null;
        //authResponseBloc = null;
        return;
      }
      //print("====================================8");

      // Elimina los tokens
      await SessionSecureStorage.clearTokens();
      //print("====================================9");

      // redireccionar al usuario al sign in
      emit(const AuthStateDeleteAccount(exception: null, isLoading: false));
      emit(const AuthStateSignedOut(exception: null, isLoading: false));
    });

    // * Sign in with providers
    on<AuthEventGoogleSignIn>((event, emit) async {
      // * imprimer las opciones e imprimir
      /* await authProvider.userIsLoggedIn(); e ir probando todos*/
      // * ver mitch coco elrereturn y ver el ger hey flutter google sign in with out firebase

      /* try {
        final GoogleSignInAccount? gogleCredentials = await GoogleSignIn().signIn();

        final googleAuth = await gogleCredentials
      
      } catch (e) {
        
      } */
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
    on<AuthEventRefreshToken>((event, emit) async {
      //! si la session el null access y refresh token mostrar sign in
      // * en sign out si la respuesta es que el token expiro deveria usar /refresh-token handler
      // o simplemente eliminar lo que queda en file storage y enviarlo al login
      // * En que funciones usaré esto en get posts

      final session = await SessionSecureStorage.getTokens();

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
      }
      //debugPrint("bloc refresh !!!!!!!!!!");
    });

    on<AuthEventEnableTwoFaSms>((event, emit) async {
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

        final (resp, respErr) = await provider.enableTwoFaSms(
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

    on<AuthEventEnableTwoFaSmsVerifyOtp>((event, emit) async {
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
        final (resp, respErr) = await provider.enableTwoFaSmsVerifyOtp(
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

    on<AuthEventTwoFaSmsVerifyOtp>((event, emit) async {
      if (state is AuthStateNeedsVerificationTwa) {
        final currentState = state as AuthStateNeedsVerificationTwa;
        emit(currentState.copyWith(
            twoFaSmsVerifyOtp: const TwoFaSmsVerifyOtp(
          isLoading: true,
        )));
        //print("initttttttttttttttttt1");
        final (resp, respErr) = await provider.twoFaSmsVerifyOtp(
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

        await SessionSecureStorage.saveTokens(
          resp!.session!.accessToken,
          resp.session!.refreshToken,
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

  @override
  Future close() {
    _branchIoSuscription.cancel();
    return super.close();
  }
}
