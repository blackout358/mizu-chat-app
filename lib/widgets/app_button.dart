import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final int borderRadius;
  final VoidCallback onPressed;
  final IconData? icon;
  final double width;
  final double height;
  final double fontSize;
  const AppButtons({
    super.key,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.width,
    required this.height,
    this.icon,
    required this.borderRadius,
    required this.onPressed,
    required this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius.toDouble()),
          border: Border.all(
            color: borderColor,
            width: 0.0,
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius.toDouble(),
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize * MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    );
  }
}
