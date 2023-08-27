import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String recieverID;
  final String message;
  final Timestamp? timestamp;
  final String? reply;

  Message(
      {required this.senderID,
      required this.senderEmail,
      required this.recieverID,
      required this.message,
      this.timestamp,
      this.reply});

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': recieverID,
      'message': message,
      'timestamp': timestamp,
      'reply': reply,
    };
  }
}
