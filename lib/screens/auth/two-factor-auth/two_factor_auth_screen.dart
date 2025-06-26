import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TwoFactorAuthScreen extends StatelessWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.verticalP,
                    horizontal: AppSizes.horizontalMediumPadding,),
                children: [
                  const SizedBox(height: 25.0),
                  const Text(
                    "Add Extra security to your account",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Two-factor authentication protects your account by requiring an additional code when you log in on a device that we don't recognise.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  //Text("Choose your security method")
                  const SizedBox(height: 15.0),

                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.blackColor),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "SMS",
                              style: TextStyle(fontSize: 17.0),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "available",
                              style: TextStyle(color: AppColors.greenColor),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                            "We'll send a code to the mobile number that your choise")
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    GoRouter.of(context)
                        .push(AppRoutes.twoFactorAuthSelectPhoneSmsRoute,);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSizes.horizontalMediumPadding,
                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
