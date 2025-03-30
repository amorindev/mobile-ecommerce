import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Text("I'm the best"),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateBranchIoStateDeepLinkToken) {
                return Text("Token: ${state.token}");
              }
              return const CircularProgressIndicator();
            },
          )
        ],
      )),
    );
  }
}
