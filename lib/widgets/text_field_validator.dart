import 'package:flutter/material.dart';

class MyDeletionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  MyDeletionTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<MyDeletionTextField> createState() => _MyDeletionTextFieldState();
}

class _MyDeletionTextFieldState extends State<MyDeletionTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF7E7E7E),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFCE93D8),
          ),
        ),
        fillColor: const Color(0xFF7E7E7E),
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
