class AppRoutes {
  AppRoutes._();

  // cuando usar /, sin / rutas hijas del GoRoute y rutas anidaas del shellRoute
  static const String branchioPageTest = '/branchio';
  static const String goFlutter = '/open';
  static const String authProviderListernScreen = '/auth-provider-listener';
  static const String authBlocListernScreen = '/auth-bloc-listener';

  // * Auth routes
  // ?sin anidar ver todavía
  static const String signInRoute = '/sign-in';
  static const String signUpRoute = '/sign-up';
  // ? escoger dependiendo -- CASO DE MONOLITOS MODULOS, como aplicarlos para microservicios
  static const String verifyEmailRoute = '/verify-email';
  static const String verifyEmailOtpRoute = '/verify-email-otp';
  // cuando el usuario hace click en el botton del correo, redirecciona a una página que se envio correctamente
  // o en otp para ingresar el
  // aunque pueden ir juntos
  static const String emailVerifiedRoute = '/email-verified';
  static const String emailVerifiedOtpRoute = '/email-verified-otp';

  // * BottomNavigationBar
  static const String homeRoute = '/home';
  // sub home dentro del navbar
  static const String subHomeRoute = '/home/sub-home';
  static const String profileRoute = '/profile';
  // this sub home sobre el navbar
  static const String subProfileRoute = '/profile/sub-profile';

  // * Others
  // error route para go_router
  static const String errorRoute = '/error';
}
