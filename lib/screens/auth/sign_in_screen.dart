import 'package:flu_go_jwt/design/colors.dart';
import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/router/routes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_button.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/exception/exceptions.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  //final ValueSetter<String> onSignIn;

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isChecked = false;
  AuthState? state;

  // hola
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        "************************".log();
        state.log();
        "************************".log();
        // * 1. Termina el inicialice el usuario es SignedOut con error nulo loading nulo
        // * 2. Hace click el usuario - esta en loading y los otros null - saltará el primer if
        // * 3. cuando termina correcto o retorna un error - loading debe ser false
        if (state is AuthStateSignedOut) {
          "-----------------------".log();
          state.log();
          "-----------------------".log();
          /* final closeDialog = _closeDialogHandle;
          if (!state.isLoading && closeDialog != null) {
            closeDialog();
            _closeDialogHandle = null;
          } else {
            _closeDialogHandle =
                showLoadingDialog(context: context, text: 'Loading');
          } */

          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              'user not found',
            );
          } else if (state is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              'Wrong credentials',
            );
          } else if (state is GenericAuthException) {
            await showErrorDialog(
              context,
              'Authentication error',
            );
          }
        }
        if (state is AuthStateSignedIn) {
          if (!state.isLoading) {
            // error al cerrar sesion
            //if (state.exeptin) {}
            if (context.mounted) {
              // ? necesita await ?
              GoRouter.of(context).pushReplacement(AppRoutes.homeRoute);
            }
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // * Que pasa con el responsive y orientacion, entonces podemos dar un tamaño en porcentajade
              // * la pantalla y us align center  todo, o el padding de igual mnera de acuerdo a la pantalla

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
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
                    const Text('Password:'),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 20),
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
                    TextButton(
                      onPressed: () {
                        /* context.read<AuthBloc>().add(
                              const AuthEventShouldSignUp(previusPage:AuthStateSignedIn(session: , user: user, isLoading: isLoading)),
                            ); */

                        context.read<AuthBloc>().add(
                            const AuthEventShouldSignUp(previusPage: null));
                      },
                      child: const Text('Not registered yet? Register here!'),
                    ),
                  ],
                ),
              ),

              //Spacer()
              // * Si no tienes un  cuenta registrate

              // * Parte 2
              /* authProvider.isLoggedIn
                  ? const Text("user loggued in")
                  : const Text("user is not loggued in"),
        
              const Text("Err"),
              authProvider.signInErr != null
                  ? Text(authProvider.signInErr!)
                  : const SizedBox(), */

              // * RememberMe, Diegoveloper hizo un en vivo donde no se necesita agregar un set estate
              // * sino un widget de animación que se usba para eso
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              // * Sign in email-password
              TextButton(
                onPressed: () async {
                  /* await authProvider.signIn(
                    _emailController.text,
                    _passwordController.text,
                    isChecked,
                  ); */
                },
                child: const Text("Sign in"),
              ),
              // * Google sign in
              /* TextButton(
                onPressed: () async {
                  await authProvider.googleSignIn();
                },
                child: const Text("Google sign in"),
              ),
        
              TextButton(
                onPressed: () async {
                  await authProvider.googleSingOut();
                },
                child: const Text("Google sign out"),
              ), */

              /* TextButton(
                onPressed: () async {
                  await authProvider.userIsLoggedIn();
                },
                child: const Text("user is logged in"),
              ), */
              TextButton(
                onPressed: () async {
                  context.read<AuthBloc>().state.log();
                },
                child: const Text("user is logged in"),
              ),
              
              TextButton(
                onPressed: () async {
                  GoRouter.of(context).push(AppRoutes.signUpRoute);
                },
                child: const Text("Go to register page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*  
onTap: () {
  // ! Se necesita async await ?
  authProvider.signIn(
    _emailController.text,
    _passwordController.text,
    isChecked,
    );
    // ! como usarlo
    if (authProvider.signInErr != null) {
    return;
    }
    // ! Cual usr bloc o gorouter y como combinar con Deeplinks
    GoRouter.of(context).pushReplacement(AppRoutes.homeRoute
  );
}, 
*/
