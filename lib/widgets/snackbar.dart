import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required String text,
    required Color textColour,
    double? fontSize,
    required double height,
    required int duration,
    required Color backgroundColor,
  }) : super(
          content: Container(
            alignment: Alignment.centerLeft,
            height: height,
            child: Text(
              text,
              style: TextStyle(
                color: textColour,
                fontSize: fontSize,
              ),
            ),
          ),
          duration: Duration(seconds: duration),
          backgroundColor: backgroundColor,
        );
}
