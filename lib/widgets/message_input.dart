import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mizu/widgets/reply_message.dart';
import 'package:mizu/widgets/text_field.dart';

class MessageInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController messageController;
  final VoidCallback sendMessage;
  final ValueNotifier<String?> replyMessage;
  const MessageInput(
      {super.key,
      required this.focusNode,
      required this.messageController,
      required this.sendMessage,
      required this.replyMessage});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                ValueListenableBuilder<String?>(
                  valueListenable: widget.replyMessage,
                  builder: (context, replyMessage, child) {
                    if (replyMessage != null) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF7E7E7E),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.purple[200]!,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          replyMessage,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // Placeholder for no reply message
                    }
                  },
                ),
                MyTextField(
                  focusNode: widget.focusNode,
                  controller: widget.messageController,
                  hintText: 'Enter message',
                  obscureText: false,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: widget.sendMessage,
            // onPressed: () => print(widget.replyMessage),
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            icon: const Icon(
              Icons.send,
              size: 40,
              color: Color.fromRGBO(206, 147, 216, 1),
            ),
          ),
        ],
      ),
    );
  }
}
