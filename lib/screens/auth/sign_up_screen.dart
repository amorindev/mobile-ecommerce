import 'package:flu_go_jwt/design/colors.dart';
import 'package:flu_go_jwt/router/routes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_button.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/exception/exceptions.dart';
import 'package:flu_go_jwt/services/auth/provider/provider.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  late final TextEditingController _confirmPassController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _confirmPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          // * verificar que se manejen todos los erroes de exception
          // * que pertenecen a sign up, asi mismo para todas las pantallas
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak Password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email already in use');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Email already in use');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              /* authProvider.errSignUp != null
                  ? Text(authProvider.errSignUp!)
                  : const SizedBox(), */
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 25.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email:'),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),

                    // * Aqui si queremos agreagar otros dtos del profile o en el sign in

                    const Text('Password:'),
                    CustomTextField(
                      controller: _passController,
                      hintText: 'Password',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 15),

                    const Text('Confirm password:'),
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
                        // trims
                        //final email = _emailController.text.trim();
                        /* authProvider.signUp(
                          _emailController.text,
                          _passController.text,
                          _confirmPassController.text,
                        ); */
                        final email = _emailController.text;
                        final password = _passController.text;
                        final confirmPassword = _confirmPassController.text;
                        context.read<AuthBloc>().add(
                              AuthEventSignUp(
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword,
                              ),
                            );
                      },
                    ),
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
                      child: const Text('Already registered? Login here!'),
                    )
                  ],
                ),
              )
            ],
            // Spacer()
            // * Si tines un cuenta registrada inicia session
          ),
        ),
      ),
    );
  }
}
