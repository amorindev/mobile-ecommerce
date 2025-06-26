import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/phone/bloc/phone_bloc.dart';
import 'package:flu_go_jwt/services/phone/core/core.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flu_go_jwt/utils/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SelectPhoneScreen extends StatefulWidget {
  const SelectPhoneScreen({super.key});

  @override
  State<SelectPhoneScreen> createState() => _SelectPhoneScreenState();
}

class _SelectPhoneScreenState extends State<SelectPhoneScreen> {
  PhoneResp? _selectedPhone;

  @override
  void initState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthStateSignedIn) {
      final accessToken = authState.authResponse!.session!.accessToken;
      BlocProvider.of<PhoneBloc>(context).add(PhoneEventGetAll(
        accessToken: accessToken,
      ));
    }
    super.initState();
  }

  void _onPhoneSelected(PhoneResp phone) {
    setState(() {
      _selectedPhone = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // TODO: implement listener

        if (state is AuthStateSignedIn) {
          final twoFa = state.twoFaData!;

          if (twoFa.isVerifying) {
            LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'loading ...',
            );
          } else {
            LoadingScreen().hide();
          }

          if (twoFa.isSuccess) {
              //print("navigate to AuthStateSignedIn twoFa.isSuccess");

            GoRouter.of(context).push(
              AppRoutes.twoFactorAuthVerifyCodeSmsRoute,
            );
            
          }

          if (twoFa.exception != null) {
            await showErrorDialog(context, state.exception.toString());
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
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
                          "Selecciona o agrega un número",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Selecciona o agrega un número de teléfono celular que ya tengas en la cuenta o agrega uno nuevo. Recibirás el código para iniciar sesión en este número",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<PhoneBloc, PhoneState>(
                          builder: (context, state) {
                            if (state is PhoneStateLoaded) {
                              if (state.phones == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state.phones!.isEmpty) {
                                return const Text(
                                  "No tienes números de teléfonos",
                                );
                              }

                              return Column(
                                children: state.phones!
                                    .map((phone) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: GestureDetector(
                                              onTap: () =>
                                                  _onPhoneSelected(phone),
                                              child: CustomPhoneCard(
                                                phone: phone,
                                                isSelected:
                                                    _selectedPhone?.id ==
                                                        phone.id,
                                              )),
                                        ))
                                    .toList(),
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_selectedPhone == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Selecciona un número primero'),
                        ),
                      );
                      return;
                    }

                    final authState = context.read<AuthBloc>().state;

                    //print(authState);
                    if (authState is! AuthStateSignedIn) {
                      return;
                    }
                    //  en este punto deberi no ser nulo
                    final accessToken =
                        authState.authResponse!.session!.accessToken;
                    context.read<AuthBloc>().add(
                          AuthEventEnableTwoFaSms(
                            accessToken: accessToken,
                            phoneId: _selectedPhone!.id,
                          ),
                        );
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
        ),
      ),
    );
  }
}

class CustomPhoneCard extends StatelessWidget {
  final PhoneResp phone;
  final bool isSelected;

  const CustomPhoneCard({
    super.key,
    required this.phone,
    this.isSelected = false,
  });

  String getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSelected ? AppColors.blueColor : AppColors.blackColor,
          width: isSelected ? 2 : 1,
        ),
        color: isSelected ? AppColors.blueColor.withOpacity(0.1) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalMediumPadding,
          vertical: AppSizes.verticalP,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getFlagEmoji(phone.countryISOCode),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              phone.number,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            phone.isVerified
                ? const Text(
                    "verified",
                    style: TextStyle(
                      color: AppColors.greenColor,
                    ),
                  )
                : const Text(
                    "verify",
                    style: TextStyle(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
