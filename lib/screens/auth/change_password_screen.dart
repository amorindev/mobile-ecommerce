import 'package:flu_go_jwt/screens/auth/widgets/custom_button.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final TextEditingController _currentPassword;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    super.initState();
    _currentPassword = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _currentPassword.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            const SizedBox(height: 60.0),
            const Text(
              textAlign: TextAlign.center,
              "Change password",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20.0),
            const Text('Current password:'),
            const SizedBox(height: 6),
            CustomTextField(
              controller: _currentPassword,
              hintText: 'current password:',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 15),
            const Text('New Password:'),
            const SizedBox(height: 6),
            CustomTextField(
              controller: _password,
              hintText: 'new password:',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 15),
            const Text('Confirm password:'),
            const SizedBox(height: 6),
            CustomTextField(
              controller: _confirmPassword,
              hintText: 'confirm password:',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 15.0),
            InkWell(
              onTap: () async {
                await showErrorDialog(context, "Funcionalidad no disponible");
              },
              child: const Text(
                'Forgot password?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 15.0),
            CustomButton(
              text: 'Change password',
              onTap: () async {
                await showErrorDialog(context, "Funcionalidad no disponible");
                //context.read<AuthBloc>().add(const AuthEventChangePassword());
              },
            ),
          ],
        ),
      ),
    );
  }
}
