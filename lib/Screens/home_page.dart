import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizu/logic/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:mizu/logic/chat/chat_service.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot documents) {
    Map<String, dynamic> data = documents.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['email'],
              style: TextStyle(
                fontSize: 22,
                // fontFamily: 'Roboto',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            StreamBuilder(
              stream: ChatService()
                  .getLastMessage(data['uid'], _auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error${snapshot.error.toString()}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    'Loading..',
                  );
                }
                try {
                  final lastMessage = snapshot.data!.docs[0];
                  final isFromUser =
                      lastMessage['senderID'] == _auth.currentUser!.uid;
                  // data['senderID'] == _auth.currentUser!.uid
                  //   ?  Text(lastMessage['message'])
                  //   : CrossAxisAlignment.start,
                  return Text(
                    lastMessage['message'],
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight:
                          isFromUser ? FontWeight.normal : FontWeight.bold,
                      fontSize: 18,
                      // fontFamily: GoogleFonts.roboto(),
                    ),
                  );
                } catch (e) {
                  return Text('');
                }
                // return Text('');
                // final lastMessage = snapshot.data!.docs[0];
                // if (snapshot.data!.docs[0].exists) {
                //   final lastMessage = snapshot.data!.docs[0];
                //   final isFromUser =
                //       lastMessage['senderID'] == _auth.currentUser!.uid;
                //   // data['senderID'] == _auth.currentUser!.uid
                //   //   ?  Text(lastMessage['message'])
                //   //   : CrossAxisAlignment.start,
                //   return Text(
                //     lastMessage['message'],
                //     style: TextStyle(
                //       color: Colors.grey[500],
                //       fontWeight:
                //           isFromUser ? FontWeight.normal : FontWeight.bold,
                //       fontSize: 17,
                //       fontFamily: 'RobotoMono',
                //     ),
                //   );
                // }
                // return Text('');
                // final isFromUser =
                //     lastMessage['senderID'] == _auth.currentUser!.uid;
                // // data['senderID'] == _auth.currentUser!.uid
                // //   ?  Text(lastMessage['message'])
                // //   : CrossAxisAlignment.start,
                // return Text(
                //   lastMessage['message'],
                //   style: TextStyle(
                //     color: Colors.grey[500],
                //     fontWeight:
                //         isFromUser ? FontWeight.normal : FontWeight.bold,
                //     fontSize: 17,
                //     fontFamily: 'RobotoMono',
                //   ),
                // );
                // return Text(lastMessage['message']);
              },
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                recieverUserEmail: data['email'],
                recieverUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
