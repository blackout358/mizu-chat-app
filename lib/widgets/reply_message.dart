import 'package:flutter/material.dart';

class ReplyMessage extends StatelessWidget {
  final String replyMessage;
  final VoidCallback onPressed;
  const ReplyMessage(
      {super.key, required this.replyMessage, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(8, 10, 35, 8),
          decoration: BoxDecoration(
            color: Color(0xFF7E7E7E),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xFFd8d393),
              width: 1,
            ),
          ),
          child: Text(
            replyMessage.toString(),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}
