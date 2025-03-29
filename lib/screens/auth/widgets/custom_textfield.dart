import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool? enableSuggestions;
  final bool? autocorrect;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.enableSuggestions,
    this.autocorrect,
  });

  @override
  Widget build(BuildContext context) {
    // es necesario geture detector?
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      obscureText: obscureText,
      keyboardType: keyboardType,
      //enableSuggestions: enableSuggestions ?? true, // false email y password
      //autocorrect: autocorrect ?? true, // false email password
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            //color: Colors.white,
            color: Colors.black,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            //color: Color.fromARGB(255, 238, 234, 234),
            color: Colors.black,
          ),
        ),
        //fillColor: Color.fromARGB(255, 238, 234, 234),
        fillColor: Colors.white,
        filled: false,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
