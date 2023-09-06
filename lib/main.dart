import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mizu/firebase_options.dart';
import 'package:mizu/logic/auth/auth_service.dart';
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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple[200],
        appBarTheme: AppBarTheme(
          color: Colors.purple[200],
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white),
        /* dark theme settings */
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF222222),
        // primaryIconTheme: Colors.white,
        primaryColor: const Color(0xFFCE93D8),
        appBarTheme: AppBarTheme(
          color: Colors.purple[200],
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Scaffold(
        body: AuthGate(),
      ),
    );
  }
}
