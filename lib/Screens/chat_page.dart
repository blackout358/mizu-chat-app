import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mizu/logic/chat/chat_service.dart';
import 'package:mizu/logic/chat/timestamp_formater.dart';
import 'package:mizu/widgets/alert_dialog.dart';
import 'package:mizu/widgets/chat_bubble.dart';
import 'package:mizu/widgets/text_field.dart';
import 'package:swipe_to/swipe_to.dart';

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
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _columnScrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   scrollToBottom();
  // }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverUserEmail),
        actions: [
          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Clear chat"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                ChatService.deleteAllMessages(
                    widget.recieverUserID, _firebaseAuth.currentUser!.uid);
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
          _buildMessageInput(),
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
          return const Text('Loading..');
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

    var userCheck = (data['senderID'] == _firebaseAuth.currentUser!.uid);
    return SwipeTo(
      onRightSwipe: () {
        print("object");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              (data['senderID'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            (data['senderID'] != _firebaseAuth.currentUser!.uid)
                ? ChatBubble(
                    message: data['message'],
                    colour: Colors.grey[400]!,
                    onPressed: () {
                      deleteMessageConfirmation(data, document.reference.id);
                    },
                  )
                : ChatBubble(
                    message: data['message'],
                    colour: Colors.purple[200]!,
                    onPressed: () {
                      deleteMessageConfirmation(data, document.reference.id);
                      // ChatService.deleteMessage(
                      //     widget.recieverUserID,
                      //     _firebaseAuth.currentUser!.uid,
                      //     document.reference.id);
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

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Enter message',
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
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
