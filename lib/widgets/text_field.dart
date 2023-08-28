import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool hideText = false;

  @override
  void initState() {
    hideText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: hideText,
      decoration: InputDecoration(
        // labelText: hintText,
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

        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  hideText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    hideText = !hideText;
                  });
                },
              )
            : null,

        fillColor: const Color(0xFF7E7E7E),
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
