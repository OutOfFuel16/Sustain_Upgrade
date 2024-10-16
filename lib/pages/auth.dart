import 'package:campus_carbon/pages/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //Logged In
          if (snapshot.hasData) {
            return const HomePage();
          }

          //Not Logged In
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
