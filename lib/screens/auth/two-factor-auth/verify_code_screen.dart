import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flu_go_jwt/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateSignedIn) {
          final verifyStatus = state.verifyOtpStatus!;

          if (verifyStatus.isLoading) {
            LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'loading ...',
            );
          } else {
            LoadingScreen().hide();
          }

          if (verifyStatus.isSuccess) {
            // * si sale todo bien mostrar y navegar al user
            //print("navigate to AuthStateSignedIn verifyStatus.isSuccess");

            GoRouter.of(context).push(
              AppRoutes.twoFactorAuthSmsSuccessSmsRoute,
            );
          }

          if (verifyStatus.exception != null) {
            await showErrorDialog(context, verifyStatus.exception.toString());
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalMediumPadding,
              vertical: AppSizes.verticalP,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        const Text(
                          "Ingresa el código de confirmación",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),

                        // ! esto debe ser dinámico no del bloc sino como parámetro
                        const Text(
                          "Ingresa el código de 6 dígitos que enviamos por sms al *** *** *33",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          "Es posible que debas esperar hasta un minuto para revibir este código.",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await showErrorDialog(context, "Funcionalidad no disponible");
                          },
                          child: const Text(
                            "Resend the code",
                            style: TextStyle(
                              color: AppColors.blueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 25.0),
                        TextField(
                          cursorColor: AppColors.blackColor,
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                //color: Colors.white,
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: false,
                            hintText: 'enter the code',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    final otpCode = _codeController.text;
                    // ver como se valida agregar trim
                    if (otpCode == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ingresa el otp'),
                        ),
                      );
                      return;
                    }
                    final authState = context.read<AuthBloc>().state;

                    if (authState is! AuthStateSignedIn) {
                      return;
                    }
                    final accessToken = authState.authResponse!.session!.accessToken;
                    context.read<AuthBloc>().add(
                          AuthEventVerifyEnableMfaSmsOtp(
                            accessToken: accessToken,
                            otpId: authState.twoFaData!.otpId!,
                            otpCode: otpCode,
                          ),
                        );

                    // ! mediante el listener tenemos que navegar si fue exitoso
                    // ! si navegamos desde el listener entones se navega solo
                    // ! quienes lo requiren, esta bien o solo
                    // ! desde listener habilitar el boton de ok ver
                    // ! ahi se puede hacer algunas cosas
                    /* GoRouter.of(context).push(
                      AppRoutes.twoFactorAuthVerifyCodeSmsRoute,
                    ); */
                  },
                  child: Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
