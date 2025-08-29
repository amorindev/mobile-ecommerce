import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_button.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_otp_box.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flu_go_jwt/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationOtpScreen extends StatefulWidget {
  const EmailVerificationOtpScreen({super.key});

  @override
  State<EmailVerificationOtpScreen> createState() => _EmailVerificationOtpScreenState();
}

class _EmailVerificationOtpScreenState extends State<EmailVerificationOtpScreen> {
  late final TextEditingController _code1;
  late final TextEditingController _code2;
  late final TextEditingController _code3;
  late final TextEditingController _code4;
  late final TextEditingController _code5;
  late final TextEditingController _code6;

  @override
  void initState() {
    super.initState();
    _code1 = TextEditingController();
    _code2 = TextEditingController();
    _code3 = TextEditingController();
    _code4 = TextEditingController();
    _code5 = TextEditingController();
    _code6 = TextEditingController();
  }

  @override
  void dispose() {
    _code1.dispose();
    _code2.dispose();
    _code3.dispose();
    _code4.dispose();
    _code5.dispose();
    _code6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // * Se manejaran dos eventos verificar el otp y reenviar el email como trabajar juntos
        // * de momento separado
        //if (state is AuthStateSignUpVerifyOtp) {
        // hay dos formas trabajar con el enum pero de momento este
        if (state is AuthStateNeedsVerification) {
          if (state.isLoading) {
            LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'loading ...',
            );
          } else {
            LoadingScreen().hide();
          }
          if (state.exp != null) {
            await showErrorDialog(context, state.exp.toString());
          }
        }

        // ! arreglar
        /* if (state is AuthStateSendEmailVerificationOTP) {
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
            if (context.mounted) {
              await showErrorDialog(context, state.exception.toString());
            }
          }
        } */
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding,
            ),
            children: [
              const SizedBox(height: 50.0),
              const Text(
                'Please verify your email address.',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10.0),
              // ! O bien pasarlo como parámetro o agregar user al stado global
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthStateNeedsVerification) {
                    return Text(
                      'We\'ve sent an email to ${state.authResponse!.user.email}, please enter the code below.',
                      style: TextStyle(color: AppColors.greyColor),
                    );
                  }
                  return const Text("an error ocurred.");
                },
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Enter code',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),

              // ? Cuál es la diferencia de llamar desde AppColors y appcolors injectarlo al context
              // con theme.ofcontext
              const SizedBox(height: 15.0),

              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // * falta con el botton de la X eliminar iría dentro de Custom
                    CustomOtpBox(
                      controller: _code1,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    CustomOtpBox(
                      controller: _code2,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    CustomOtpBox(
                      controller: _code3,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    CustomOtpBox(
                      controller: _code4,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    CustomOtpBox(
                      controller: _code5,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    CustomOtpBox(
                      controller: _code6,
                      onChanged: (value) {
                        if (value.length == 1) {
                          //FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: const Text("back"),
              ),
              const SizedBox(height: 250.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: 'Resend',
                    onTap: () {
                      context.read<AuthBloc>().add(const AuthEventResendVerifyEmailOtp());
                    },
                  ),
                  CustomButton(
                    onTap: () {
                      final otpCode = "${_code1.text}${_code2.text}${_code3.text}";
                      final otpCode2 = "$otpCode${_code4.text}${_code5.text}${_code6.text}";
                      context.read<AuthBloc>().add(
                            AuthEventVerifyEmailOtp(
                              otpCode: otpCode2,
                            ),
                          );
                    },
                    text: 'Confirm',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
