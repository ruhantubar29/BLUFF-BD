import 'package:flutter/material.dart';

class BluffButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final double fontSize;

  const BluffButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height = 56,
    this.width = double.infinity,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}