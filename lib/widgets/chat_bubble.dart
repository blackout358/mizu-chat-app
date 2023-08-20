import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Color colour;
  final VoidCallback onPressed;
  const ChatBubble({
    super.key,
    required this.message,
    required this.colour,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      // onHorizontalDragEnd: onDragged,
      child: Container(
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
      ),
    );
  }
}
