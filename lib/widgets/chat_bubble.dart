import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleDragEnd() {
    if (dragDistance >= MediaQuery.of(context).size.width * 0.25) {
      print("Reply");
      controller.forward(from: 0.0);
    } else if (offsetX.abs() > 10.0) {
      controller.forward();
    } else {
      controller.reverse();
      offsetX = 0.0;
      dragDistance = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          double delta = details.primaryDelta ?? 0.0;
          double maxDrag = MediaQuery.of(context).size.width * 0.25;
          setState(
            () {
              offsetX = (offsetX + delta).clamp(-maxDrag, maxDrag);
              dragDistance += delta.abs();
            },
          );
          if (!animating) {
            // Start animation when offsetX is beyond threshold
            if (offsetX.abs() > 30.0) {
              controller.forward();
            } else {
              controller.reverse();
            }
          }
        },
        onHorizontalDragEnd: (details) {
          handleDragEnd();
          // setState(() {
          //   offsetX = 0.0;
          //   dragDistance = 0.0;
          //   animating = false;
          // });
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


// import 'package:flutter/material.dart';
// import 'package:swipe_to/swipe_to.dart';

// class ChatBubble extends StatefulWidget {
//   final String message;
//   final Color colour;
//   final VoidCallback onPressed;
//   final ValueChanged<double>? valueChanged;
//   const ChatBubble({
//     super.key,
//     required this.message,
//     required this.colour,
//     required this.onPressed,
//     this.valueChanged,
//   });

//   @override
//   State<ChatBubble> createState() => _ChatBubbleState();
// }

// class _ChatBubbleState extends State<ChatBubble> {
//   ValueNotifier<double> valueListener = ValueNotifier(.0);

//   @override
//   void initState() {
//     valueListener.addListener(notifyParent);
//     super.initState();
//   }

//   void notifyParent() {
//     if (widget.valueChanged != null) {
//       widget.valueChanged!(valueListener.value);
//     }
//   }
//   // final GlobalKey _draggableKey = GlobalKey();
//   // late double maxDraggableDistance;
//   // Offset? originalPosition;
//   // Offset _draggableOffset = Offset.zero;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // maxDraggableDistance = MediaQuery.of(context).size.width * 0.25;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onPressed,
//       onHorizontalDragUpdate: (details) {
//         double dragExtent =
//             details.primaryDelta! / MediaQuery.of(context).size.width;
//         double clampedDragExtent = dragExtent.clamp(-0.25, 0.25);

//         // Adjust alignment logic here (e.g., pass clampedDragExtent to a parent widget)
//       },
//       onHorizontalDragEnd: (details) {
//         print("Reply");
//       },
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.75,
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: widget.colour,
//         ),
//         child: Text(
//           widget.message,
//           style: const TextStyle(
//             fontSize: 16,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );

//     // return GestureDetector(
//     //   onTap: widget.onPressed,

//     //   child: Container(
//     //     padding: const EdgeInsets.all(12),
//     //     constraints: BoxConstraints(
//     //       maxWidth: MediaQuery.of(context).size.width * 0.75,
//     //     ),
//     //     decoration: BoxDecoration(
//     //       borderRadius: BorderRadius.circular(8),
//     //       color: widget.colour,
//     //     ),
//     //     child: Text(
//     //       widget.message,
//     //       style: const TextStyle(
//     //         fontSize: 16,
//     //         color: Colors.white,
//     //       ),
//     //     ),
//     //   ),
//     // );
//     // return Draggable(
//     //   key: _draggableKey,
//     //   axis: Axis.horizontal,
//     //   onDragStarted: () {
//     //     maxDraggableDistance = MediaQuery.of(context).size.width * 0.25;
//     //     final RenderBox renderBox =
//     //         _draggableKey.currentContext!.findRenderObject() as RenderBox;
//     //     originalPosition = renderBox.localToGlobal(Offset.zero);
//     //   },
//     //   onDragUpdate: (details) {
//     //     final distanceTraveled =
//     //         (details.localPosition.dx - originalPosition!.dx).abs();

//     //     if (distanceTraveled > maxDraggableDistance) {
//     //       final clampedX = details.localPosition.dx > originalPosition!.dx
//     //           ? originalPosition!.dx + maxDraggableDistance
//     //           : originalPosition!.dx - maxDraggableDistance;

//     //       final clampedOffset = details.localPosition.dy > originalPosition!.dy
//     //           ? Offset(clampedX, details.localPosition.dy)
//     //           : Offset(clampedX, details.localPosition.dy);

//     //       setState(() {
//     //         _draggableOffset = clampedOffset;
//     //       });

//     //       _draggableKey.currentContext!
//     //           .findRenderObject()
//     //           ?.showOnScreen(duration: Duration(milliseconds: 100));
//     //     } else {
//     //       setState(() {
//     //         _draggableOffset = details.localPosition;
//     //       });
//     //     }
//     //   },
//     //   onDragEnd: (details) {
//     //     final RenderBox renderBox =
//     //         _draggableKey.currentContext!.findRenderObject()! as RenderBox;
//     //     final offset = renderBox.localToGlobal(Offset.zero);
//     //     final distanceTraveled = (details.offset.dx - offset.dx).abs();

//     //     final quarterScreenWidth = MediaQuery.of(context).size.width * 0.25;

//     //     if (distanceTraveled >= quarterScreenWidth) {
//     //       print("replied"); // Perform the reply action
//     //     }
//     //   },
//     //   childWhenDragging: Container(
//     //     padding: const EdgeInsets.all(12),
//     //     constraints: BoxConstraints(
//     //       maxWidth: MediaQuery.of(context).size.width * 0.75,
//     //     ),
//     //     decoration: BoxDecoration(
//     //       borderRadius: BorderRadius.circular(8),
//     //       color: Colors.transparent,
//     //     ),
//     //     child: Text(
//     //       widget.message,
//     //       style: const TextStyle(
//     //         fontSize: 16,
//     //         color: Colors.transparent,
//     //       ),
//     //     ),
//     //   ),
//     //   feedback: Material(
//     //     child: Container(
//     //       // Customize the appearance of the dragged widget if needed

//     //       padding: const EdgeInsets.all(12),
//     //       constraints: BoxConstraints(
//     //         maxWidth: MediaQuery.of(context).size.width * 0.75,
//     //       ),
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(8),
//     //         color: widget.colour,
//     //       ),
//     //       child: Text(
//     //         widget.message,
//     //         style: const TextStyle(
//     //           fontSize: 16,
//     //           color: Color.fromARGB(255, 255, 255, 255),
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // child: GestureDetector(
//     //   onTap: widget.onPressed,
//     //   child: Container(
//     //     padding: const EdgeInsets.all(12),
//     //     constraints: BoxConstraints(
//     //       maxWidth: MediaQuery.of(context).size.width * 0.75,
//     //     ),
//     //     decoration: BoxDecoration(
//     //       borderRadius: BorderRadius.circular(8),
//     //       color: widget.colour,
//     //     ),
//     //     child: Text(
//     //       widget.message,
//     //       style: const TextStyle(
//     //         fontSize: 16,
//     //         color: Colors.white,
//     //       ),
//     //     ),
//     //   ),
//     //   ),
//     // );
//   }
// }
