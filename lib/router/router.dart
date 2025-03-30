import 'package:flu_go_jwt/practice2_screen.dart';
import 'package:flu_go_jwt/router/routes.dart';
import 'package:flu_go_jwt/screens/auth/auth_bloc_listener.dart';
import 'package:flu_go_jwt/screens/auth/auth_provider_listener.dart';
import 'package:flu_go_jwt/screens/auth/email_verified_screen.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flu_go_jwt/screens/auth/sign_up_screen.dart';
import 'package:flu_go_jwt/screens/auth/email_verification_test.dart';
import 'package:flu_go_jwt/screens/bottom_nav_bar.dart';
import 'package:flu_go_jwt/screens/email_verification_page.dart';
import 'package:flu_go_jwt/screens/email_verification_screen.dart';
import 'package:flu_go_jwt/screens/home_screen.dart';
import 'package:flu_go_jwt/screens/profile_screen.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// EN el caso de un ecommerce lo mejor seria ir a home agregar productos
// si necesita alguna funcion que requiera inicio de sesion le redirigiría
// Como manejarlo con bloc ? -de momento solo con provider

// * ver el flujo de branch io con eleenlace si es desed el stream
// * no seria necesario go_router y usaríamos ongenerated route
// * ventajas de hacer con codewith andread deeplinks funciona bien
// * pero no tiene la funcionalidad de ir a la tienda si no esta instalada la app
// * hacer un lego software?
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

class AppRouter2 {
  AppRouter2._();
  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _rootNavHome = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );
  static final _rootNavProfile = GlobalKey<NavigatorState>(
    debugLabel: 'shellProfile',
  );
  static Route<dynamic>? onGenerateRoute2(RouteSettings settings) {}
  static final GoRouter router = GoRouter(
    //initialLocation: AppRoutes.signInRoute,
    initialLocation: AppRoutes.authBlocListernScreen,
    navigatorKey: _rootNavHome,
    //initialLocation: AppRoutes.authListernScreen,
    debugLogDiagnostics: true, // quitar en producción
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.practice,
        //builder: (context, state) => const PracticeScreen(),
        builder: (context, state) => const Practice2Screen(),
      ),
      /* GoRoute(
        path: AppRoutes.branchioPageTest,
        builder: (context, state) => const BrancIoPage(),
      ), */
      GoRoute(
        path: '/open',
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("(open)"),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.authProviderListernScreen,
        builder: (context, state) {
          return const AuthProviderListener();
        },
      ),
      GoRoute(
        path: AppRoutes.authBlocListernScreen,
        builder: (context, state) {
          context.read<AuthBloc>().add(const AuthEventInitialize());
          return const AuthBlocListener();
        },
      ),
      GoRoute(
        path: AppRoutes.signInRoute,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailVerifiedRoute,
        builder: (context, state) => const EmailVerifiedScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmailRoute,
        builder: (context, state) => const EmailVerificationScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _rootNavHome,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.homeRoute,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavProfile,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profileRoute,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      )
    ],
  );
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.signInRoute,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      /* routes: [
        GoRoute(
          path: 'details/:itemId',
          builder: (context, state) {
            return DetailScreen(itemId: state.pathParameters['itemId']!);
          },
        ),
      ], */
    ),
    /*  GoRoute(
      path: '/branchio',
      builder: (context, state) => const BranchioVerify(),
    ), */
    GoRoute(
      path: '/:token',
      builder: (context, state) {
        return EmailVerificationPage(token: state.pathParameters['token']!);
      },
    ),
  ],
  /* redirect: (context, state) {
    // lo que quiero es que navego el usario y un cambio
    final authState = context.read<AuthBloc>().state;
    // si el estado global tiene user
    //if (state.user) {}
    // * aqui lo que no quiero es que se mantenga en sign in cuando el usario navego a otra pantalla
    // ? se debe verificar is loading y el error?
    if (authState is AuthStateSignedIn) {
      return AppRoutes.homeRoute;
    }
    if (authState is AuthStateNeedsVerification) {
      return AppRoutes.verifyEmailRoute;
    }
    if (authState is AuthStateSignedOut) {
      return AppRoutes.signInRoute;
    }
    return "";
  }, */
);
