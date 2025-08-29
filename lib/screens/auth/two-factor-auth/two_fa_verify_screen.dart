import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flu_go_jwt/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TwoFaVerifyScreen extends StatefulWidget {
  const TwoFaVerifyScreen({super.key});

  @override
  State<TwoFaVerifyScreen> createState() => _TwoFaVerifyScreenState();
}

class _TwoFaVerifyScreenState extends State<TwoFaVerifyScreen> {
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
        if (state is AuthStateNeedsVerificationTwa) {
          final verifyStatus = state.twoFaSmsVerifyOtp!;
          // * Loading
          if (verifyStatus.isLoading) {
            if (context.mounted) {
              LoadingScreen().show(
                context: context,
                text: state.loadingText ?? 'loading ...',
              );
            }
          } else {
            LoadingScreen().hide();
          }
          if (verifyStatus.exp != null) {
            await showErrorDialog(context, verifyStatus.exp.toString());
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
                          const SizedBox(height: 17.0),
                          const Text(
                            "Verificación en dos pasos",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            //"Hemos enviado un código de 6 dígitos a $maskedPhoneOrEmail", // ← Este valor lo pasas por parámetro
                            "Hemos enviado un código de 6 dígitos a tu correo", // ← Este valor lo pasas por parámetro
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Por favor, ingresa el código para continuar con tu inicio de sesión.",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () async {
                              await showErrorDialog(context, "Funcionalidad no disponible");
                              // on resend a partir de un minuto
                            }, // ← Callback
                            child: const Text(
                              "Reenviar código",
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
                            maxLength: 6,
                            decoration: const InputDecoration(
                              counterText: "", // Oculta el contador de caracteres
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Ingresa el código de 6 dígitos',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                      context.read<AuthBloc>().add(AuthEventVerifyMfaSmsOtp(
                            otpCode: otpCode,
                          ));
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
                          "Verificar",
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
          ),
        ),
      ),
    );
  }
}
