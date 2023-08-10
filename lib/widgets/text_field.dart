import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
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
      controller: widget.controller,
      obscureText: hideText,
      decoration: InputDecoration(
        // labelText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF7E7E7E)!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFe090df),
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
