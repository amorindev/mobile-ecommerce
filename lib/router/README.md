// * Solo example, ademas el redirect sería centralizado
// * La idea es estar lo mas desacoplado posible


/* static final GoRouter router = GoRouter(
  initialLocation: AppRoutes.authBlocListernScreen,
  navigatorKey: _rootNavKey,
  redirect: (BuildContext context, GoRouterState state) {
    final authState = context.read<AuthBloc>().state;
    
    if (authState is AuthStateSignedIn) {
      return AppRoutes.homeRoute;
    }
    if (authState is AuthStateNeedsVerification) {
      return AppRoutes.verifyEmailRoute;
    }
    if (authState is AuthStateSignedOut) {
      return AppRoutes.signInRoute;
    }
    return null; // null significa "no redirigir"
  },
  routes: [...], // tus rutas existentes
); */