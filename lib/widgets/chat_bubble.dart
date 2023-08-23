import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final Color colour;
  final bool isSender;
  final VoidCallback onPressed;

  ChatBubble({
    required this.message,
    required this.colour,
    required this.isSender,
    required this.onPressed,
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  double offsetX = 0.0; // Horizontal offset for dragging
  double dragDistance = 0.0;
  bool animating = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  void handleDragEnd() {
    setState(() {
      if (dragDistance >= MediaQuery.of(context).size.width * 0.20) {
        print("Reply");
        // controller.forward();
        controller.reverse();
        print("OffsetX $offsetX");
        print("Drag distance: $dragDistance");
        offsetX = 0;
        dragDistance = 0;
      } else {
        // controller.forward();
        controller.reverse();

        print("OffsetX $offsetX");
        print("Drag distance: $dragDistance");
        offsetX = 0;
        dragDistance = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          print("OffsetX $offsetX");
          print("Drag distance: $dragDistance");
          // widget.onPressed;
        },
        onHorizontalDragUpdate: (details) {
          double delta = details.primaryDelta ?? 0.0;
          double maxDrag = MediaQuery.of(context).size.width * 0.25;
          setState(
            () {
              offsetX = (offsetX + delta).clamp(-maxDrag, maxDrag);
              dragDistance += delta.abs();
            },
          );
        },
        onHorizontalDragCancel: () {
          handleDragEnd();
        },
        onHorizontalDragEnd: (details) {
          handleDragEnd();
        },
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                offsetX - (offsetX * controller.value),
                0.0,
                // offsetX = 0,
              ),
              child: child,
            );
          },
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
      ),
    );
  }
}
