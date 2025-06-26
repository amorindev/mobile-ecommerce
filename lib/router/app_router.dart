import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/screens/addresses_screen.dart';
import 'package:flu_go_jwt/screens/admin_screen.dart';
import 'package:flu_go_jwt/screens/auth/change_password_screen.dart';
import 'package:flu_go_jwt/screens/auth/delete_account_screen.dart';
import 'package:flu_go_jwt/screens/auth/email_verification_otp_screen.dart';
import 'package:flu_go_jwt/screens/auth/email_verified_screen.dart';
import 'package:flu_go_jwt/screens/auth/forgot_password_screen.dart';
import 'package:flu_go_jwt/screens/auth/maps_select_address_screen.dart';
import 'package:flu_go_jwt/screens/auth/phone_screen.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flu_go_jwt/screens/auth/sign_up_screen.dart';
import 'package:flu_go_jwt/screens/auth/two-factor-auth/sms_success_screen.dart';
import 'package:flu_go_jwt/screens/auth/two-factor-auth/two_fa_verify_screen.dart';
import 'package:flu_go_jwt/screens/auth/two-factor-auth/two_factor_auth_screen.dart';
import 'package:flu_go_jwt/screens/auth/two-factor-auth/select_phone_screen.dart';
import 'package:flu_go_jwt/screens/auth/two-factor-auth/verify_code_screen.dart';
import 'package:flu_go_jwt/screens/bottom_nav_bar.dart';
import 'package:flu_go_jwt/screens/ecomm/store/maps_show_stores_screen.dart';
import 'package:flu_go_jwt/screens/email_verification_screen.dart';
import 'package:flu_go_jwt/screens/home_screen.dart';
import 'package:flu_go_jwt/screens/onboarding_screen.dart';
import 'package:flu_go_jwt/screens/ecomm/product/cart_screen.dart';
import 'package:flu_go_jwt/screens/ecomm/product/check_out_screen.dart';
import 'package:flu_go_jwt/screens/ecomm/product/payment_screen.dart';
import 'package:flu_go_jwt/screens/ecomm/product_detail_screen.dart';
import 'package:flu_go_jwt/screens/ecomm/product/product_detail_without_variants.dart';
import 'package:flu_go_jwt/screens/ecomm/product/purchases_screen.dart';
import 'package:flu_go_jwt/screens/ecomm/product/shipping_screen.dart';
import 'package:flu_go_jwt/screens/profile_screen.dart';
import 'package:flu_go_jwt/screens/settings_screen.dart';
import 'package:flu_go_jwt/services/ecomm/product/model/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  static final _rootNavCart = GlobalKey<NavigatorState>(
    debugLabel: 'shellCart',
  );

  static final _rootNavPurcharses = GlobalKey<NavigatorState>(
    debugLabel: 'shellPurcharses',
  );
  static final GoRouter router = GoRouter(
    // * O con el redirect basta ?
    // * O poner GoRouter con el path "/" como ruta inicial ?
    initialLocation: AppRoutes.onboardingRoute,
    navigatorKey: _rootNavKey,
    //debugLogDiagnostics: true, // quitar en producción
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.onboardingRoute,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/open',
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("(open)"),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.signInRoute,
        builder: (context, state) => const SignInScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.forgotPasswordNameRoute,
            builder: (context, state) {
              final email = state.pathParameters['email'];
              return ForgotPasswordScreen(
                email: email,
              );
            },
          ),
          GoRoute(
            path: 'two-fa-verify',
            builder: (context, state) {
              return const TwoFaVerifyScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.signUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmailRoute,
        builder: (context, state) => const EmailVerificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmailOtpRoute,
        builder: (context, state) => const  EmailVerificationOtpScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailVerifiedRoute,
        builder: (context, state) => const EmailVerifiedScreen(),
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
                builder: (context, state) => HomeScreen(
                  key: state.pageKey,
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'product-detail',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) {
                      // pasarlo si no dara error de ejecución?
                      final product = state.extra as Product;
                      return ProductDetailScreen(
                        key: state.pageKey,
                        product: product,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'product-detail-without-variants',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) {
                      // pasarlo si no dara error de ejecución?
                      final product = state.extra as Product;
                      return ProductDetailWithOutVariants(
                        key: state.pageKey,
                        product: product,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavCart,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.cartRoute,
                builder: (context, state) => CartScreen(
                  key: state.pageKey,
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'checkout',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) {
                      // pasarlo si no dara error de ejecución?
                      /* final product =
                              state.extra as ProductsResponseProduct;
                          return ProductDetailScreen(
                            key: state.pageKey,
                            product: product,
                          ); */
                      return const CheckOutScreen();
                    },
                    routes: [
                      // ? cuando pasar el key
                      GoRoute(
                        path: 'shipping',
                        parentNavigatorKey: _rootNavKey,
                        builder: (context, state) {
                          /* final product =
                              state.extra as ProductsResponseProduct;
                          return ProductDetailScreen(
                            key: state.pageKey,
                            product: product,
                          ); */
                          return const ShippingScreen();
                          // /cart/checkout/shipping
                        },
                        routes: [
                          GoRoute(
                            path: 'maps',
                            parentNavigatorKey: _rootNavKey,
                            builder: (context, state) {
                              final position = state.extra as LatLng;
                              return MapsShowStoresScreen(initialP: position);
                            },
                          ),
                          GoRoute(
                            path: 'payment',
                            parentNavigatorKey: _rootNavKey,
                            builder: (context, state) {
                              /* final product =
                              state.extra as ProductsResponseProduct;
                          return ProductDetailScreen(
                            key: state.pageKey,
                            product: product,
                          ); */
                              return const PaymentScreen();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavPurcharses,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.purchasesRoute,
                builder: (context, state) => PurcharsesScreen(
                  key: state.pageKey,
                ),
                /* routes: <RouteBase>[
                    GoRoute(
                        path: 'product-detail',
                        parentNavigatorKey: _rootNavKey,
                        builder: (context, state) {
                          // pasarlo si no dara error de ejecución?
                          final product =
                              state.extra as ProductsResponseProduct;
                          return ProductDetailScreen(
                            key: state.pageKey,
                            product: product,
                          );
                        },),
                  ], */
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavProfile,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profileRoute,
                builder: (context, state) => ProfileScreen(
                  key: state.pageKey,
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'change-password',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) => ChangePasswordScreen(
                      key: state.pageKey,
                    ),
                  ),
                  GoRoute(
                    path: 'settings',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) => SettingsScreen(
                      key: state.pageKey,
                    ),
                  ),
                  GoRoute(
                    path: 'admin',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) => AdminScreen(
                      key: state.pageKey,
                    ),
                  ),
                  GoRoute(
                    path: 'address',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) => AddressesScreen(
                      key: state.pageKey,
                    ),
                    routes: [
                      GoRoute(
                        path: 'maps',
                        parentNavigatorKey: _rootNavKey,
                        builder: (context, state) => MapsSelectAddressScreen(
                          key: state.pageKey,
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'phones',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) => PhoneScreen(
                      key: state.pageKey,
                    ),
                  ),
                  //
                  GoRoute(
                    path: 'two-factor-auth',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) => TwoFactorAuthScreen(
                      key: state.pageKey,
                    ),
                    routes: [
                      GoRoute(
                        path: 'select-phone',
                        parentNavigatorKey: _rootNavKey,
                        builder: (context, state) => SelectPhoneScreen(
                          key: state.pageKey,
                        ),
                        routes: [
                          GoRoute(
                            path: 'verify-code',
                            parentNavigatorKey: _rootNavKey,
                            builder: (context, state) => VerifyCodeScreen(
                              key: state.pageKey,
                            ),
                            routes: [
                              GoRoute(
                                path: 'two-factor-sms-success',
                                parentNavigatorKey: _rootNavKey,
                                builder: (context, state) => SmsSuccessScreen(
                                  key: state.pageKey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'delete-account',
                    parentNavigatorKey: _rootNavKey,
                    builder: (context, state) => DeleteAccountScreen(
                      key: state.pageKey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ],
  );
}

/* final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details/:itemId', // esto me suena a web
          builder: (context, state) {
            return DetailScreen(itemId: state.pathParameters['itemId']!);
          },
        ),
      ],
    ),

  ],
); */
