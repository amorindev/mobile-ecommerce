// * ver el flujo de branch io con eleenlace si es desed el stream
// * no seria necesario go_router y usaríamos ongenerated route
// * ventajas de hacer con codewith andread deeplinks funciona bien
// * pero no tiene la funcionalidad de ir a la tienda si no esta instalada la app
// * hacer un lego software?

/*
import 'package:flu_go_jwt/router/routes.dart';
import 'package:flu_go_jwt/screens/auth/auth_bloc_listener.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flu_go_jwt/screens/email_verification_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case AppRoutes.authBlocListernScreen:
        return MaterialPageRoute(
          builder: (context) => const AuthBlocListener(),
        );
      case AppRoutes.emailVerifiedRoute:
        return MaterialPageRoute(
          // * recover
          builder: (context) => const EmailVerificationScreen(),
        );

      /* default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
          ),
        ); */
      default:
        return MaterialPageRoute(
          builder: (context) => const AuthBlocListener(),
        );
    }
  }
} */