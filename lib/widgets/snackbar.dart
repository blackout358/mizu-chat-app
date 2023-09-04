import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
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

  static void snackBarOne(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        text: text,
        textColour: Colors.black,
        height: 30,
        duration: 2,
        fontSize: 20,
        backgroundColor: Colors.purple[200]!,
      ),
    );
  }
}
