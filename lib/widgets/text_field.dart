import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        // labelText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[200]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFe090df),
          ),
        ),
        fillColor: Colors.grey[400]!,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
