import 'package:flutter/material.dart';

class ReplyMessage extends StatelessWidget {
  final String message;
  const ReplyMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            message,
          ),
        ),
      ],
    );
  }
}
