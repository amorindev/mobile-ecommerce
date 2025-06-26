import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_textfield.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  // * es necesario cuando le flujo es corto y rápido
  // * De momento lo vamos usar por que el container no muestra
  // * que se presiono el boton
  Future<void> showDeletePasswordDialog(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar contraseña'),
        content: const Text('¿Estás seguro de que quieres eliminar tu contraseña? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      if (context.mounted) {
        final password = _passwordController.text;
        context.read<AuthBloc>().add(AuthEventDeleteAccount(password: password));
      }
    } /* else {
      print('Eliminación cancelada');
    } */
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        //print("This is a state: $state");
        /* if (state is AuthStateDeleteAccount) {
          if (state.exception != null) {
            print("hello hello");
            await showErrorDialog(context, state.exception.toString());
          }
          // ! cuando elimino mi cuenta me  redirige a sign in
          // ! y al precionar backbutton me retirna al profile scree bug
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
        } */
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalMediumPadding,
            ),
            child: Column(
              children: [
                const SizedBox(height: 90.0),
                const Text(
                  "Delete account",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Para tu seguridad, por favor digite su contraseña para eliminar su cuenta",
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  //onTap: () => showDeletePasswordDialog(context),
                  onTap: () async {
                    await showErrorDialog(context, "Funcionalidad no disponible");
                  },
                  child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      color: AppColors.brandColor,
                      borderRadius: BorderRadius.circular(8.0),
                      //border: Border.all(),
                    ),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Delete account",
                        style: TextStyle(color: Colors.white),
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
