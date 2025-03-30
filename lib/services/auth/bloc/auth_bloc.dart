import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/services/auth/gateway/auth_gateway.dart';
import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:flu_go_jwt/services/branchio/service.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'auth_event.dart';
part 'auth_state.dart';

// * se puede hacer de dos maneras dejr auth provider con todos uth google facebook
// * o separar por proveedor en cad de servicio, facebook
// * events producen states

// ? cundo realizo a current user siempre es de local storage?
// ! estas usando el current user pero el current user se saca de localstorage
// ! no del estado



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BranchioService _srv = BranchioService();
  // ? como inicializar
  late StreamSubscription<Map<dynamic, dynamic>> _branchIoSuscription;
  //late final StreamSubscription<Map<dynamic, dynamic>>? streamSubscription;

  AuthBloc(AuthGateway provider)
      // debería ser false y dentro del evento AuthEventInitialize recien true
      : super(const AuthStateUninitialized(
          isLoading: true,
        )) {
    //AuthBloc(AuthGateway provider) : super(const AuthStateUninitialized()) {
    on<AuthEventSendEmailVerification>((event, emit) async {
      final session = await provider.currentUser;
      if (session != null) {
        await provider.sendEmailVerification(email: session.user.email);
        emit(state);
      }
    });

    on<AuthEventSignUp>((event, emit) async {
      final email = event.email;
      final password = event.password;
      final confirmPassword = event.confirmPassword;
      final (user, respErr) = await provider.signUp(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (respErr != null) {
        emit(AuthStateRegistering(exception: respErr, isLoading: false));
      }
      // agregar el usuario al estado para enviar email de verificación
      emit(const AuthStateNeedsVerification(isLoading: false));
    });

    on<AuthEventInitialize>((event, emit) async {
      print("Initialize!!!!!!!!!!!!!!");
      // wait provider.initiaize();
      // ver si el token es válido o pedor al

      final session = await provider.currentUser;
      if (session == null) {
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
      } else if (session.user.emailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      }
      /* emit(AuthStateSignedIn(
          session: session!, user: session.user, isLoading: false)); */
    });

    on<AuthEventSignIn>((event, emit) async {
      emit(const AuthStateSignedOut(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait while I sign you in',
      ));

      // para probar oading dialog
      await Future.delayed(const Duration(seconds: 3));

      final email = event.email;
      final password = event.password;
      final rememberMe = event.rememberMe;

      final (session, signInErr) = await provider.signIn(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
      // if (signInErr != null && session != null)
      if (signInErr != null) {
        emit(AuthStateSignedOut(exception: signInErr, isLoading: false));
      }
      // aqui no seria para no hacer dos veces
      // emit(const AuthStateSignedOut(exception: null, isLoading: false));
      if (!session!.user.emailVerified) {
        // necesitamos cerrar la pantalla de loading
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(const AuthStateSignedOut(exception: null, isLoading: false));
        emit(AuthStateSignedIn(
          session: session,
          user: session.user,
          isLoading: false,
        ));
      }
    });

    // ver que datos se puede scar de stasdo
    // por que en el esta principal no se pone la session
    on<AuthEventSignOut>((event, emit) async {
      // ? Loading ? si agreagar
      // En este punto el refreshtoken o la session no deben ser nulos
      /*  final userCredential = await provider.currentUser;
      if (userCredential != null) {
        await provider.signOut(refreshToken: userCredential.refreshToken);
      } */
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

      // la session va en el state global y por que el loading si?
      //final respErr = await provider.signOut(refreshToken: state.session.refreshToken);
    });

    on<AuthEventShouldSignUp>((event, emit) {
      emit(const AuthStateRegistering(
        exception: null,
        isLoading: false,
      ));
    });

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
      if (event.email == null) {
        // * me parece que no podemos poner AuthStateForgotPassword encima de un return;
        /* emit(AuthStateForgotPassword(
          isLoading: false,
          exception: Exception("Email is required"),
          hasSentEmail: false,
        )); */

        // * aqui o debajo del if como ahora
        return;
      }
      emit(const AuthStateForgotPassword(
        isLoading: true,
        exception: null,
        hasSentEmail: false,
      ));

      final respErr = await provider.sendForgotPassword(email: event.email!);
      if (respErr != null) {
        emit(
          AuthStateForgotPassword(
              isLoading: false, exception: respErr, hasSentEmail: false),
        );
      }
      emit(const AuthStateForgotPassword(
        isLoading: false,
        exception: null,
        hasSentEmail: true,
      ));
    });

    on<AuthEventBranchIoEventSuscribe>((event, emit) async {
      emit(const AuthStateBranchIoStateDeepLinkToken(
          token: "my-token", isLoading: false));
      _branchIoSuscription = _srv.branchIoStream.listen(
        (data) async {
          if (data.isNotEmpty) {
            "BranchioService -  data is not empty".log();
            // if (data != null && data.containsKey('token'))
            if (data.containsKey('token')) {
              String? token = data['token'];
              if (token != null) {
                "BranchioService -  token is not empty this is a token".log();
                token.log();
                "----------------------------------".log();
                /* emit(
                  AuthStateBranchIoStateDeepLinkToken(
                    token: token,
                    isLoading: false,
                  ),
                ); */
                add(AuthEventNewTokenReceived(token: token));
              }
            }
          } else {
            "BranchioService -  data is empty".log();
          }
        },
        onError: (error) {
          ("Branchio err $error").log();
          // ? emitir estado?
        },
      );
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
  }
  @override
  Future close() {
    _branchIoSuscription.cancel();
    return super.close();
  }
}
