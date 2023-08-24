import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  late Animation<double> iconOpacityAnimation;
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    iconOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void handleDragEnd() {
    setState(() {
      if (dragDistance >= MediaQuery.of(context).size.width * 0.20) {
        print("Reply");
        // controller.animateTo(0.99);

        // controller.forward();
        controller.reverse();
        print("OffsetX $offsetX");
        print("Drag distance: $dragDistance");
        // controller.
        offsetX = 0;
        dragDistance = 0;
      } else {
        // controller.forward();
        controller.reverse();

        print("OffsetX $offsetX");
        print("Drag distance: $dragDistance");
        // controller.reset();
        offsetX = 0;
        dragDistance = 0;
      }
    });
    // controller.reverse();
  }

  double calculateArrowOpacity(double size) {
    return (offsetX / size).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Stack(
        alignment:
            widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Transform.scale(
            scaleX: widget.isSender ? 1 : -1,
            child: Icon(
              Icons.reply,
              color: Colors.amberAccent,
            ),
          ),
          GestureDetector(
            onTap: () {
              print("OffsetX $offsetX");
              print("Drag distance: $dragDistance");
              // widget.onPressed;
            },
            onHorizontalDragUpdate: (details) {
              double delta = details.primaryDelta ?? 0.0;
              double maxDrag = 30;
              // iconOpacityAnimation = (offsetX /
              //     MediaQuery.of(context).size.width *
              //     0.25) as Animation<double>;
              // print(controller);
              // print(iconOpacityAnimation);
              setState(
                () {
                  offsetX = (offsetX + delta).clamp(-maxDrag, maxDrag);
                  dragDistance += delta.abs();
                },
              );
              // iconOpacityAnimation = Tween<double>(
              //   begin: 0.0,
              //   end: (offsetX / maxDrag).clamp(0.0, 1.0),
              // ) as Animation<double>;
            },
            onHorizontalDragCancel: () {
              handleDragEnd();
              // controller.reset();
              // controller.dispose();
            },
            onHorizontalDragEnd: (details) {
              handleDragEnd();
              // controller.reset();
              // controller.dispose();
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
                key: _key,
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
        ],
      ),
    );
  }
}
