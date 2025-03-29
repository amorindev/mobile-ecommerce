// * si el loading bloquea la pantalla asegurarse se desbloquear cuando la api
// * retorne la respuesta sin importar si hubo algún eror

import 'package:flutter/material.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog(
    {required BuildContext context, required String text}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10.0),
        Text(text),
      ],
    ),
  );
  showDialog(
    context: context,
    //Lo que hacemos es decir que si el usuario toca fuera de este diálogo, se permite o no cerrarlo.
    barrierDismissible: false,
    builder: (context) => dialog,
  );
  // Navigator podria confunidr al estac de navegacion a no ser que crees  o modifiques un estado
  // bool se muestra show dialog?
  return () => Navigator.of(context).pop();
}
