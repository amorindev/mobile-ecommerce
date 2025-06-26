import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatefulWidget {
  final Function()? onTap;
  final TextEditingController? controller;
  const CustomDateTimePicker({super.key, required this.onTap,required this.controller});

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}


// ! existen dos formas en flutter una es que le pases el controller
// ! y la otra opcion es que retornes el valor del datetime ver
class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: widget.controller,
      decoration: const InputDecoration(
        labelText: 'Date',
        filled: true,
        prefixIcon: Icon(Icons.calendar_today),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        fillColor: AppColors.whiteColor,
        floatingLabelStyle: TextStyle(color: AppColors.blackColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blackColor),
        ),
      ),
      readOnly: true,
      onTap: widget.onTap,
    );
  }
}
