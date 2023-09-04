import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      // Sign in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      return userCredential;
    }
    // catch errors
    on FirebaseAuthException catch (e) {
      // print(e.code);
      throw Exception(e);
    }
  }

  // Create user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  void signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> updatePassword(String password) async {
    try {
      // Sign in
      var user = _firebaseAuth.currentUser;

      user?.updatePassword(password);
      // return "Successfully updated password";
    }
    // catch errors
    on FirebaseAuthException catch (e) {
      // print(e.code);
      throw Exception(e);
    }
  }

  // Future<void> updateEmail(String email) async {
  //   try {
  //     var user = _firebaseAuth.currentUser;

  //     user?.updateEmail(email);
  //   }
  //   // catch errors
  //   on FirebaseAuthException catch (e) {
  //     // print(e.code);
  //     throw Exception(e);
  //   }
  // }

  Future<void> deleteAccount(String email) async {
    try {
      var user = _firebaseAuth.currentUser;

      user?.delete();
    }
    // catch errors
    on FirebaseAuthException catch (e) {
      // print(e.code);
      throw Exception(e);
    }
  }
}
