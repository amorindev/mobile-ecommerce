import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flu_go_jwt/screens/email_verification_screen.dart';
import 'package:flu_go_jwt/screens/home_screen.dart';
import 'package:flu_go_jwt/services/auth/provider/provider.dart';
import 'package:flu_go_jwt/services/branchio/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProviderListener extends StatefulWidget {
  const AuthProviderListener({super.key});

  @override
  State<AuthProviderListener> createState() => _AuthProviderListenerState();
}

class _AuthProviderListenerState extends State<AuthProviderListener> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, BranchIoProvider>(
      builder: (context, authProvider, branchIoProvider, child) {
        ("BranchIo - DeepLinkData: ${branchIoProvider.deepLinkData.toString()}")
            .log();
        if (authProvider.session != null) {
          return const HomeScreen();
        } else if (branchIoProvider.deepLinkData != null) {
          // hacer la validacion como el medium
          /* if (data.containsKey('token')) {
        String? token = data['token'];
        if (token != null) {
          "Branch io service".log();
          //token.log();
          "Branch io service".log();
          // TODO: lo enviámos al backend
        }
      } */
          return const EmailVerificationScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
