import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final Color colour;
  final bool isSender;
  final String? reply;
  final VoidCallback onPressed;
  final VoidCallback onDragged;

  ChatBubble({
    required this.message,
    required this.colour,
    required this.isSender,
    required this.onPressed,
    required this.onDragged,
    this.reply,
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  double offsetX = 0.0; // Horizontal offset for dragging
  double dragDistance = 0.0;
  double maxDrag = 30;
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
  }

  void handleDragEnd() {
    setState(
      () {
        if (dragDistance >= maxDrag) {
          widget.onDragged();
          controller.reverse();
          offsetX = 0;
          dragDistance = 0;
        } else {
          controller.reverse();
          print("OffsetX $offsetX");
          print("Drag distance: $dragDistance");
          offsetX = 0;
          dragDistance = 0;
        }
      },
    );
  }

  void handleDragUpdate(DragUpdateDetails details) {
    double delta = details.primaryDelta ?? 0.0;

    setState(
      () {
        widget.isSender
            ? offsetX = (offsetX + delta).clamp(-maxDrag, 0)
            : offsetX = (offsetX + delta).clamp(0, maxDrag);
        dragDistance += delta.abs();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Stack(
        alignment:
            widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Opacity(
            opacity: offsetX.abs() / 30,
            child: Transform.scale(
              scaleX: widget.isSender ? 1 : -1,
              child: Icon(
                Icons.reply,
                color: offsetX.abs() / 30 < 1 ? Colors.grey[200] : Colors.blue,
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onPressed,
            onHorizontalDragUpdate: (details) {
              handleDragUpdate(details);
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
                child: Column(
                  children: [
                    if (widget.reply != null)
                      Text(
                        widget.reply!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
