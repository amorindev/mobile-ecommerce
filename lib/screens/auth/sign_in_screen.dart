import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_button.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/exception/auth_exceptions.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flu_go_jwt/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  //final ValueSetter<String> onSignIn;

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

// ! ver el flujo completo y como esta la pila si necesario logs

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isChecked = false;
  AuthState? state;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final orientation = MediaQuery.of(context).orientation;
    //final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // * 1. Termina el inicialice el usuario es SignedOut con error nulo loading nulo
        // * 2. Hace click el usuario - esta en loading y los otros null - saltará el primer if
        // * 3. cuando termina correcto o retorna un error - loading debe ser false
        if (state is AuthStateSignedOut) {
          // * Loading
          if (state.isLoading) {
            if (context.mounted) {
              LoadingScreen().show(
                context: context,
                text: state.loadingText ?? 'loading ...',
              );
            }
          } else {
            LoadingScreen().hide();
          }
          if (state.exception != null) {
            if (state.exception is UserNotFoundAuthException) {
              await showErrorDialog(
                context,
                'user not found',
              );
            } else if (state.exception is WrongPasswordAuthException) {
              await showErrorDialog(
                context,
                'Wrong credentials',
              );
            } else if (state.exception is GenericAuthException) {
              await showErrorDialog(
                context,
                'Authentication error',
              );
            } else if (state.exception != null) {
              await showErrorDialog(context, state.exception.toString());
            }
          }
        }
        // * Aqui es un punto donde limpia el router para que no se llene
        // * pero que pasa si el usuario hace  back retrocede correctamente
        // * pero el estado se perdería
        if (state is AuthStateSignedIn) {
          if (context.mounted) {
            GoRouter.of(context).pushReplacement(AppRoutes.homeRoute);
          }
        }
        // ? debe ser el único en toda la app?
        if (state is AuthStateNeedsVerification) {
          // ver si otros tambien necestan navigate AuthStateSignedIn
          // veo al hacer sigend in una pantalla minima
          if (state.navigate) {
            if (context.mounted) {
              //print("navigate to AuthStateNeedsVerification");
              GoRouter.of(context).push(
                AppRoutes.verifyEmailOtpRoute,
              );
            }
          }
        }
        if (state is AuthStateNeedsVerificationTwa) {
          if (state.navigate) {
            if (context.mounted) {
              //print("navigate to AuthStateNeedsVerificationTwa");
              GoRouter.of(context).push(
                AppRoutes.twoFaVerifyRoute,
              );
            }
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalPadding,
                ),
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    textAlign: TextAlign.center,
                    'Sign in',
                    style: TextStyle(
                      color: AppColors.brandColor,
                      fontSize: 34.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // * Que pasa con el responsive y orientacion, entonces podemos dar un tamaño en porcentajade
                  // * la pantalla y us align center  todo, o el padding de igual mnera de acuerdo a la pantalla
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Email:'),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      const Text('Password:'),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),

                      // * RememberMe, Diegoveloper hizo un en vivo donde no se necesita agregar un set estate
                      // * sino un widget de animación que se usba para eso
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          const SizedBox(width: 6),
                          SizedBox(
                            height: 12.0,
                            width: 12.0,
                            child: Checkbox(
                              activeColor: AppColors.blueColor,
                              splashRadius: 10,
                              side: const BorderSide(width: 1.2),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          // esto es cuando el access token no caduca, el back retorna access y refresh token nuevamente
                          // o es como lo estaos haciendo solo retorna nuevo access token
                          const Text("Keep me signed in"),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              final email = _emailController.text;
                              GoRouter.of(context).push('${AppRoutes.forgotPasswordRoute}/$email');
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(color: AppColors.blueColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      CustomButton(
                        text: 'Sign in',
                        onTap: () {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          final rememberMe = isChecked;
                          context.read<AuthBloc>().add(
                                AuthEventSignIn(
                                  email: email,
                                  password: password,
                                  rememberMe: rememberMe,
                                ),
                              );

                          // * avanzar el video, capta l lógica
                          // * agregar el bloc en go_router
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Text(
                        ' Or continue with ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 30),

                  //const ShowProvidersButtons(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: // * un inkwell se ve mejor
                        Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not registered yet?,',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black54,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            /* context.read<AuthBloc>().add(
                                        const AuthEventShouldSignUp(
                                          previusPage: null,
                                        ),
                                      ); */
                            GoRouter.of(context).push(AppRoutes.signUpRoute);
                          },
                          child: const Text(
                            ' Register here!',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.blueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Positioned(bottom: 0, left: 25.0, child: Text("hello")),
            ],
          ),
        ),
      ),
    );
  }
}
