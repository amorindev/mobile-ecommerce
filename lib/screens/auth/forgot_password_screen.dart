import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_button.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? email;

  const ForgotPasswordScreen({super.key, this.email});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.text = widget.email ?? "";
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding,
          ),
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Forgot password?',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10.0),

            Text(
              'Enter the email address registered with your account. We\'ll send you a linl to reset your password',
              style: TextStyle(color: AppColors.greyColor),
            ),
            const SizedBox(height: 30.0),

            //const Text('Email:'),
            //const SizedBox(height: 6),
            CustomTextField(
              controller: _emailController,
              hintText: 'Enter your email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15.0),
            // ? verificar primero en el backend si existe una cuenta con este email
            // * verificar si el email es invalido
            CustomButton(
              text: 'Resed password',
              onTap: () async{
                /* final email =  _emailController.text.trim();
              context.read<AuthBloc>().add( AuthEventForgotPassword(email:email)); */
                await showErrorDialog(context, "Funcionalidad no disponible");
              },
            ),
            Row(
              children: [
                const Text('Didn\'t see you email?'),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Didn\'t see you email?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
