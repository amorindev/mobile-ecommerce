class AppRoutes {
  AppRoutes._();

  // ? cuando usar /, sin / rutas hijas del GoRoute y rutas anidaas del shellRoute

  // * Auth routes
  // ?sin anidar ver todavía
  static const String signInRoute = '/sign-in';
  static const String twoFaVerifyRoute = '/sign-in/two-fa-verify';

  static const String onboardingRoute = '/onboarding';
  static const String forgotPasswordNameRoute = 'forgot-password';
  static const String forgotPasswordRoute = '/sign-in/forgot-password';
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
  static const String changePasswordRoute = '/profile/change-password';
  static const String settingsRoute = '/profile/settings';
  static const String adminRoute = '/profile/admin';
  static const String addressRoute = '/profile/address';
  static const String addressMapRoute = '/profile/address/maps';
  static const String phonesRoute = '/profile/phones';
  static const String deleteAccountRoute = '/profile/delete-account';
  static const String twoFactorAuthRoute = '/profile/two-factor-auth';
  static const String twoFactorAuthSelectPhoneSmsRoute =
      '/profile/two-factor-auth/select-phone';
  static const String twoFactorAuthVerifyCodeSmsRoute =
      '/profile/two-factor-auth/select-phone/verify-code';
  static const String twoFactorAuthSmsSuccessSmsRoute =
      '/profile/two-factor-auth/select-phone/verify-code/two-factor-sms-success';

  // * Rutas que perteneces al product DDD mejor separarlos
  static const String productDetailRoute = '/home/product-detail';
  static const String productDetailWithOutVariantsRoute =
      '/home/product-detail-without-variants';
  static const String cartRoute = '/cart';
  // tambien se podía hacer con page view pero no hacer swift horizontal no permitir,
  // por que se tiene que validar campos
  // o hacerlo automaticamente cuando precione el boton continuar
  // ahi se apreciará la barra de estado 1 2 3 del flujo del pago con animacion ver el ideal y seguro
  // no seria algo mas como checkou payment - por que checkout no se si solo es para pagos
  // cambiar paymentRoute a checout route
  static const String checkOutRoute =
      '/cart/checkout'; // datos del cleinte bueno lo tenemos algunos
  static const String shippingRoute = '/cart/checkout/shipping';
  static const String shippingMapsRoute = '/cart/checkout/shipping/maps';
  static const String paymentRoute = '/cart/checkout/shipping/payment';
  static const String purchasesRoute = '/purchases';

  // * De momento no
  //static const String favoriteRoute = '/favorites';

  // * Others
  // error route para go_router
  static const String errorRoute = '/error';
}
