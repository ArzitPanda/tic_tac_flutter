import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Shadow> shadow;

  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.shadow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        shadows: shadow,
      ),
    );
  }
}
