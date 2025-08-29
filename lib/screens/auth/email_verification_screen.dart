// * verify con solo enlace
// * verify con otp
// * parece que puedo usar la misma pantalla se a confirmado sucessfully bolver al home
// *

// * Como definir la lógica por ejemplo al registrarse el backend envia un send email si falla
// * 'err-send-email' y volvemos a enviar desde esta pantalla, si no se prouduce este tipo de error,
// * mostramos Se envio un mensaje

import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: ListView(
        children: [
          const Text(
            'We\'ve sent you an email verification. Please open it to verify your account.',
          ),
          const Text(
            'If you haven\'t received a verification email yet, press the button bellow.',
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    const AuthEventResendVerifyEmailOtp(),
                  );
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () {
              // usando url launcher
            },
            child: const Text("Revisar mi email"),
          ),
          // * teniamos la lógica de hacer register y ya no valover a la página de login
          // * pero como obtengo la session, como el usuario se registro ya tengo el usuario
          // * el usuario cuando toca el token retorna a mi app, entonces envio sus datos y el token
          // * e inicio session o (no adecuado puede ser por que pasará a no ser que verifique su email, que
          // * pasa con los tokens) al registrar creo el usuaario e inicio session - ver cual es el
          // * flujo correcto
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventSignOut());
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
