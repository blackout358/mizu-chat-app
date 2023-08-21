import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatBubble extends StatefulWidget {
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
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  GlobalKey _draggableKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Draggable(
      key: _draggableKey,
      axis: Axis.horizontal,
      childWhenDragging: Container(
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Text(
          widget.message,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.transparent,
          ),
        ),
      ),
      feedback: Material(
        child: Container(
          // Customize the appearance of the dragged widget if needed

          padding: const EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.colour,
          ),
          child: Text(
            widget.message,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
      onDragStarted: () {},
      onDragUpdate: (details) {},
      onDragEnd: (details) {
        final RenderBox renderBox =
            _draggableKey.currentContext!.findRenderObject()! as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        final distanceTraveled = (details.offset.dx - offset.dx).abs();

        final quarterScreenWidth = MediaQuery.of(context).size.width * 0.25;

        if (distanceTraveled >= quarterScreenWidth) {
          print("replied"); // Perform the reply action
        }
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.colour,
          ),
          child: Text(
            widget.message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
