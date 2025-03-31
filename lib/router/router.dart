import 'package:flu_go_jwt/practice2_screen.dart';
import 'package:flu_go_jwt/router/routes.dart';
import 'package:flu_go_jwt/screens/auth/auth_bloc_listener.dart';
import 'package:flu_go_jwt/screens/auth/auth_provider_listener.dart';
import 'package:flu_go_jwt/screens/auth/email_verified_screen.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flu_go_jwt/screens/auth/sign_up_screen.dart';
import 'package:flu_go_jwt/screens/bottom_nav_bar.dart';
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
class AppRouter {
  AppRouter._();
  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _rootNavHome = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );
  static final _rootNavProfile = GlobalKey<NavigatorState>(
    debugLabel: 'shellProfile',
  );
  static final GoRouter router = GoRouter(
    // * O con el redirect basta ?
    // * O poner GoRouter con el path "/" como ruta inicial ?
    initialLocation: AppRoutes.authBlocListernScreen,
    navigatorKey: _rootNavKey,
    debugLogDiagnostics: true, // quitar en producción
    routes: <RouteBase>[
      GoRoute(
        path: '/open',
        builder: (context, state) => Scaffold(
            appBar: AppBar(
          title: const Text("(open)"),
        )),
      ),
      GoRoute(
        path: AppRoutes.authBlocListernScreen,
        builder: (context, state) {
          //context.read<AuthBloc>().add(const AuthEventInitialize());
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
    /* redirect: (context, state) {
      // * Dejaremos a redirect que maneje la navegacion a home y no desde el listener
      // se puede dejar authbloc istener solo con el listener con el el builder
      // asi nos evitamos de gorouter sería como un redirect

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
}

/* final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details/:itemId',
          builder: (context, state) {
            return DetailScreen(itemId: state.pathParameters['itemId']!);
          },
        ),
      ],
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
);
 */