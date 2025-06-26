import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpBox extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomOtpBox({super.key, required this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.0,
      width: 50.0,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        // * Que pasa si es alphanumérico
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
