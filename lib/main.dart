import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizu/Screens/login_page.dart';
import 'package:mizu/firebase_options.dart';
import 'package:mizu/logic/auth/auth_service.dart';
import 'package:mizu/logic/auth/login_or_register.dart';
import 'package:provider/provider.dart';

import 'logic/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple[200],
        appBarTheme: AppBarTheme(
          color: Colors.purple[200],
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: AuthGate(),
      ),
    );
  }
}
