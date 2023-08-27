import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mizu/model/message.dart';
import 'package:mizu/widgets/snackbar.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage(
      String recieverID, String message, String reply) async {
    // current user info
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      recieverID: recieverID,
      message: message,
      timestamp: timestamp,
      reply: reply,
    );

    List<String> ids = [
      currentUserID,
      recieverID,
    ];
    ids.sort();
    String chatRoomID = ids.join('-');

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Get message

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("-");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("-");

    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots();
  }

  static deleteMessage(
      String userID, String otherUserID, String message) async {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("-");
    try {
      await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomID)
          .collection('messages')
          .doc(message)
          .delete()
          .then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
    } catch (e) {
      CustomSnackBar(
          text: e.toString(),
          textColour: Colors.black,
          height: 40,
          duration: 5,
          backgroundColor: Colors.purple[200]!);
    }
  }

  static deleteAllMessages(String userID, String otherUserID) async {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("-");
    try {
      final batch = FirebaseFirestore.instance.batch();
      final messageCollection = FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomID)
          .collection('messages');

      final querySnapshot = await messageCollection.get();
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        batch.delete(docSnapshot.reference);
      }
      await batch.commit();
    } catch (e) {
      CustomSnackBar(
          text: e.toString(),
          textColour: Colors.black,
          height: 40,
          duration: 5,
          backgroundColor: Colors.purple[200]!);
    }
  }
}
