import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_button.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/exception/auth_exceptions.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flu_go_jwt/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  late final TextEditingController _confirmPassController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _confirmPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false, // No permite cerrarlo tocando afuera
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  message ?? 'Cargando...',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          // * Loading screen
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
            if (state.exception is WeakPasswordAuthException) {
              await showErrorDialog(context, 'Weak Password');
            } else if (state.exception is EmailAlreadyInUseAuthException) {
              await showErrorDialog(context, 'Email already in use');
            } else if (state.exception is InvalidEmailAuthException) {
              await showErrorDialog(context, 'Invalid email');
            } else if (state.exception is GenericAuthException) {
              await showErrorDialog(context, 'Authentication err');
            } else if (state.exception != null) {
              await showErrorDialog(context, state.exception.toString());
            }
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding,
            ),
            children: [
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                'Sign up',
                style: TextStyle(
                  color: AppColors.brandColor,
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 25.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Names:'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Names',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  const Text('Email:'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),

                  // * Aqui si queremos agreagar otros dtos del profile o en el sign in

                  const Text('Password:'),
                  const SizedBox(height: 5),

                  CustomTextField(
                    controller: _passController,
                    hintText: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 15),

                  const Text('Confirm password:'),
                  const SizedBox(height: 5),

                  CustomTextField(
                    controller: _confirmPassController,
                    hintText: 'Confirm password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Sign up',
                    onTap: () {
                      // ! Donde se realizrian las validaciones en la pantalla en el bloc?, con form?
                      //final email = _emailController.text.trim();
                      final email = _emailController.text;
                      final password = _passController.text;
                      final confirmPassword = _confirmPassController.text;
                      context.read<AuthBloc>().add(
                            AuthEventSignUp(
                              email: email,
                              password: password,
                              confirmPassword: confirmPassword,
                              name: _nameController.text,
                            ),
                          );
                    },
                  ),

                  const SizedBox(height: 30),

                  //const ShowProvidersButtons(),
                  TextButton(
                    onPressed: () {
                      // ! Recuerda que sign ou puede tener otras responsabiidades
                      // ! no solo navegar a login
                      // ! mejor es crear otro como AuthEventShouldSignUp
                      //context.read<AuthBloc>().add(const AuthEventSignOut());
                      //GoRouter.of(context).go(AppRoutes.signInRoute);
                      // ! hacer try catch?
                      // * pop causa error mejor solo go
                      // * probar el backbutton
                      // Funcionaaaaaaaaaaaaaaaaaaaaaaaaaa
                      // ver todo el flijo si es necesario try catch ysolo return parano producir errores
                      GoRouter.of(context).pop();
                    },
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Already registered? Login here!',
                        //textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.blueColor),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
