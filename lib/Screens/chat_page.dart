import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mizu/logic/chat/chat_service.dart';
import 'package:mizu/logic/chat/timestamp_formater.dart';
import 'package:mizu/widgets/alert_dialog.dart';
import 'package:mizu/widgets/chat_bubble.dart';
import 'package:mizu/widgets/message_input.dart';

class ChatPage extends StatefulWidget {
  final String recieverUserEmail;
  final String recieverUserID;
  const ChatPage(
      {super.key,
      required this.recieverUserEmail,
      required this.recieverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _columnScrollController = ScrollController();
  ValueNotifier<String?> replyMessage = ValueNotifier<String?>(null);
  final FocusNode focusNode = FocusNode();

  void replyToMessage(String data) {
    replyMessage.value = data;
    focusNode.requestFocus();
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserID, messageController.text, replyMessage.value);
      messageController.clear();
    }
  }

  void clearReply() async {
    replyMessage.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverUserEmail),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Clear chat",
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return MyAlertDialog(
                      dialogTitle: 'Confirm',
                      dialogText:
                          "Are you sure you want to delete all messages?",
                      onPressed: () {
                        ChatService.deleteAllMessages(widget.recieverUserID,
                            _firebaseAuth.currentUser!.uid);
                      },
                    );
                  }),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          MessageInput(
            focusNode: focusNode,
            messageController: messageController,
            sendMessage: () async {
              final sendMessageFuture = Future.sync(sendMessage);
              final clearReplyFuture = Future.sync(clearReply);

              await Future.wait([sendMessageFuture, clearReplyFuture]);
            },
            replyMessage: replyMessage,
            clearReply: () {
              clearReply();
            },
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.recieverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error.toString()}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.purple[200]!,
              size: 125,
            ),
          );
        }

        return ListView(
          controller: _columnScrollController,
          reverse: true,
          children: snapshot.data!.docs.reversed
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              (data['senderID'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            (data['senderID'] != _firebaseAuth.currentUser!.uid)
                ? ChatBubble(
                    reply: data['reply'],
                    message: data['message'],
                    colour: Colors.grey[400]!,
                    onPressed: () {
                      deleteMessageConfirmation(data, document.reference.id);
                    },
                    isSender: false,
                    onDragged: () {
                      replyToMessage(document['message'] ?? '');
                    },
                  )
                : ChatBubble(
                    reply: data['reply'],
                    message: data['message'],
                    colour: Colors.purple[200]!,
                    onPressed: () {
                      deleteMessageConfirmation(data, document.reference.id);
                    },
                    isSender: true,
                    onDragged: () {
                      replyToMessage(document['message'] ?? '');
                    },
                  ),
            Text(TimestampFormater.getHourMinute(data['timestamp']))
          ],
        ),
      ),
    );
  }

  Future<dynamic> deleteMessageConfirmation(
      Map<String, dynamic> data, String id) {
    return showDialog(
      context: context,
      builder: ((context) {
        return MyAlertDialog(
          dialogTitle: 'Confirm',
          dialogText: "Are you sure you want to delete this message?",
          onPressed: () {
            ChatService.deleteMessage(
                widget.recieverUserID, _firebaseAuth.currentUser!.uid, id);
          },
        );
      }),
    );
  }
}
