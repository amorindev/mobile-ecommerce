import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateBranchIoStateDeepLinkToken) {
          if (!state.isLoading) {
            GoRouter.of(context).go(AppRoutes.emailVerifiedRoute);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              children: const [Text("Email verified successfully")],
            ),
          ),
        );
      },
    );
  }
}

/*
void verifyEmailToken(String token) async {
    final url = Uri.parse('http');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}));

    if (response.statusCode == 200) {
      _showDialog("Exito", "Correo verificado");
    } else {
      _showDialog("Error", "token inválido o ha expirado");
    }
  }
 */
