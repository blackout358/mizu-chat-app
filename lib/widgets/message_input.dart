import 'package:flutter/material.dart';
import 'package:mizu/widgets/text_field.dart';

class MessageInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController messageController;
  final VoidCallback sendMessage;
  const MessageInput(
      {super.key,
      required this.focusNode,
      required this.messageController,
      required this.sendMessage});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MyTextField(
                  focusNode: widget.focusNode,
                  controller: widget.messageController,
                  hintText: 'Enter message',
                  obscureText: false,
                ),
              ),
              IconButton(
                onPressed: widget.sendMessage,
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
