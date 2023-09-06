import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mizu/logic/auth/login_or_register.dart';

import 'package:mizu/Screens/login_page.dart';

import '../../Screens/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user is logged in
            if (snapshot.hasData) {
              return const HomePage();
            }
            // user NOT logged in
            else {
              return LoginOrRegister();
            }
          }),
    );
  }
}
