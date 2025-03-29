import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/router/routes.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flu_go_jwt/screens/auth/sign_up_screen.dart';
import 'package:flu_go_jwt/screens/auth/verify_email_screen.dart';
import 'package:flu_go_jwt/screens/email_verification_screen.dart';
import 'package:flu_go_jwt/screens/home_screen.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/utils/helpers/loading/loading_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBlocListener extends StatefulWidget {
  const AuthBlocListener({super.key});

  @override
  State<AuthBlocListener> createState() => _AuthBlocListenerState();
}

class _AuthBlocListenerState extends State<AuthBlocListener> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    //context.read<AuthBloc>().add(const AuthEventBranchIoEventSuscribe());
    // * como se comporta AuthProviderListener y AuthBLocListener
    // * Cuando se presiona el backButton
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print("State: $state");
        if (state.isLoading) {
          //LoadingScreenController().s
        }
        if (state is AuthStateBranchIoStateDeepLinkToken) {
          "********************************************3".log();
          //return const EmailVerificationScreen();
          /* Navigator.of(context).pushNamed(
            AppRoutes.emailVerifiedRoute,
          ); */
          "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!".log();
          state.token.log();
          "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!".log();
          print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          print(state.token);
          print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        }
      },
      builder: (context, state) {
        print("%%%%%%%%%%%%%%%%%%%%%");
        print(state);
        print("%%%%%%%%%%%%%%%%%%%%%");
        "*********************************************".log();
        /* if (state is BranchIoStateDeepLinkToken) {
          state.token.log();
          "thissssssssssssssssssssssss".log();
          print(state.token);
          Navigator.of(context).pushNamed(
            AppRoutes.emailVerifiedRoute,
          );
        } */
        "*********************************************".log();
        if (state is AuthStateSignedIn) {
          "*********************************************1".log();
          return const HomeScreen();
        } else if (state is AuthStateNeedsVerification) {
          "*********************************************2".log();
          return const VerifyEmailScreen();
        } else if (state is AuthStateSignedOut) {
          "*********************************************4".log();
          if (state is AuthStateBranchIoStateDeepLinkToken) {
            return Scaffold(
              appBar: AppBar(title: const Text("llegamos"),),
            );
          }
          return const SignInScreen();
        } else if (state is AuthStateBranchIoStateDeepLinkToken) {
          "********************************************3".log();
          //return const EmailVerificationScreen();
          return const Scaffold(
            body: Center(
              child: Text('llegamos '),
            ),
          );
        } else if (state is AuthStateRegistering) {
          "*********************************************5".log();
          return const SignUpScreen();
        } else {
          // ? no se prece al splash screen entonces despuesd desl splsh otr pagina de crgando?
          // * mejor agregar
          //context.read<AuthBloc>().add(const AuthEventInitialize());
          // en el main por que este junto al splash screen
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
// * como ver el estado actual cuando se presiona el deeplink
// * hacer una nueva entidad para el Equatable o ahi mismo resulta que los props deben estar todos
// * que pasa si es un objeto hasta ahora probamos puro primitivos

/*
listener: (context, deepLinkState) {
           
 */
