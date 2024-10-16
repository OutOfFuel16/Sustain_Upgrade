import 'package:campus_carbon/pages/login.dart';
import 'package:campus_carbon/pages/register_page.dart';
import 'package:flutter/material.dart';




class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool loginPage = true;


  void togglePages() {
    setState(() {
      loginPage = !loginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginPage) {
      return LoginPage(
        onTapRegister: togglePages,
      );
    } else {
      return RegisterPage(
        onTapRegister: togglePages,
      );
    }
  }
}
