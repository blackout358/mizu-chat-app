import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mizu/widgets/reply_message.dart';
import 'package:mizu/widgets/text_field.dart';

class MessageInput extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController messageController;
  final VoidCallback sendMessage;
  final ValueNotifier<String?> replyMessage;
  final VoidCallback clearReply;
  const MessageInput(
      {super.key,
      required this.focusNode,
      required this.messageController,
      required this.sendMessage,
      required this.replyMessage,
      required this.clearReply});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    ValueListenableBuilder<String?>(
                      valueListenable: widget.replyMessage,
                      builder: (context, replyMessage, child) {
                        if (replyMessage != null) {
                          return ReplyMessage(
                            replyMessage: replyMessage,
                            onPressed: widget.clearReply,
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
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: widget.sendMessage,
                // onPressed: () => print(widget.focusNode.hasFocus),
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: const Icon(
                  Icons.send,
                  size: 40,
                  color: Color.fromRGBO(206, 147, 216, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
