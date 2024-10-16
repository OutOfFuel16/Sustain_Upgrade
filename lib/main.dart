import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/splash.dart';
import 'keys/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.quicksand(textStyle:TextStyle(
            color: Colors.grey[800],fontWeight: FontWeight.w500
          ))
        ),
      ),
      home: const SplashScreen(),
    );
  }
}


