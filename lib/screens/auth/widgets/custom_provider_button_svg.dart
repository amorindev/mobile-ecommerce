import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ! tambien agregarlo al sign up
class CustomProviderButtonSvg extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const CustomProviderButtonSvg({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        child: SvgPicture.asset(imagePath),
      ),
    );
  }
}
