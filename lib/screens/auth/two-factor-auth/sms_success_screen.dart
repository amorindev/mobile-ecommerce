import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmsSuccessScreen extends StatelessWidget {
  const SmsSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ! como volver a profile sin afectar la navegacion
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sms success",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  context.go(AppRoutes.profileRoute);
                },
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
