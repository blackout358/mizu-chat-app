import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizu/logic/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:mizu/logic/chat/chat_service.dart';

import '../logic/chat/timestamp_formater.dart';
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
        leading: IconButton(
          onPressed: () {
            print("heh");
          },
          icon: Icon(
            Icons.settings,
            // color: Colors.purple[300],
          ),
        ),
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
                fontSize: 25,
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lastMessage['message'],
                        // textAlign: TextAlign.end,
                        style: TextStyle(
                          color: isFromUser
                              ? Colors.grey[500]!
                              : Colors.purple[200],
                          fontWeight:
                              isFromUser ? FontWeight.normal : FontWeight.bold,
                          fontSize: 22,
                          // fontFamily: GoogleFonts.roboto(),
                        ),
                      ),
                      Text(
                        "${TimestampFormater.formatTime(lastMessage['timestamp'])}",
                        // textAlign: TextAlign.end,
                        style: TextStyle(
                          color: isFromUser
                              ? Colors.grey[500]!
                              : Colors.purple[200],
                          fontWeight:
                              isFromUser ? FontWeight.normal : FontWeight.bold,
                          fontSize: 22,
                          // fontFamily: GoogleFonts.roboto(),
                        ),
                      ),
                    ],
                  );
                } catch (e) {
                  return Text('');
                }
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
