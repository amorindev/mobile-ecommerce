import 'package:flu_go_jwt/router/routes.dart';
import 'package:flu_go_jwt/screens/auth/auth_bloc_listener.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flu_go_jwt/screens/email_verification_screen.dart';
import 'package:flutter/material.dart';

class OngeneratedRouter {
  /* static Route<dynamic>? Function(RouteSettings)? onGenerateRoute =
      (settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
      return MaterialPageRoute(builder: (context) => const SignInScreen(),);
      default:
        return MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: CircularProgressIndicator(),),),)
    }
  }; */

  static Route<dynamic>? onGenerateRoute2(RouteSettings settings) {
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
}

/* Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
  switch (settings.name) {
    //
    case AppRoutes.loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case AppRoutes.registerPage:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case AppRoutes.verifyEmailPage:
      return MaterialPageRoute(builder: (context) => const VerifyEmailPage());

    case AppRoutes.notesPage:
      return MaterialPageRoute(builder: (context) => const NotesPage());
    case AppRoutes.homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());

    case AppRoutes.profilePage:
      return MaterialPageRoute(builder: (context) => const ProfilePage());

    case AppRoutes.createUpdateNotePage:
      return MaterialPageRoute(
        builder: (context) => CreateUpdateNotePage(
          note: settings.arguments as CloudNote?,
        ),
      );

    default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}; */
