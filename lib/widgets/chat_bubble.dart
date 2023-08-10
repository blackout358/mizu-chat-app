import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Color colour;
  const ChatBubble({
    super.key,
    required this.message,
    required this.colour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colour,
      ),
      child: Text(
        message,
        // softWrap: true,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
