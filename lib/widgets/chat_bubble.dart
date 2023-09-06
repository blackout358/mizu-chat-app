import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final Color colour;
  final bool isSender;
  final String? reply;
  final VoidCallback onPressed;
  final VoidCallback onDragged;

  const ChatBubble({
    super.key,
    required this.message,
    required this.colour,
    required this.isSender,
    required this.onPressed,
    required this.onDragged,
    this.reply,
  });

  @override
  ChatBubbleState createState() => ChatBubbleState();
}

class ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  double offsetX = 0.0;
  double maxDrag = 30;
  late AnimationController controller;
  late Animation<double> iconOpacityAnimation;
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void handleDragEnd() {
    setState(
      () {
        if (offsetX.abs() >= maxDrag) {
          widget.onDragged();
          controller.reverse();
          offsetX = 0;
        } else {
          controller.reverse();
          offsetX = 0;
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
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.colour,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.reply != null)
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[500],
                          border: Border(
                            left: BorderSide(
                              color: Colors.purple[300]!,
                              width: 5,
                            ),
                            right: BorderSide(
                              color: Colors.purple[300]!,
                              width: 0,
                            ),
                            top: BorderSide(
                              color: Colors.purple[300]!,
                              width: 0,
                            ),
                            bottom: BorderSide(
                              color: Colors.purple[300]!,
                              width: 0,
                            ),
                          ),
                        ),
                        child: Text(
                          widget.reply!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(widget.reply != null ? 5 : 0,
                          widget.reply != null ? 5 : 0, 5, 0),
                      child: Text(
                        widget.message,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
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
