import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campus_carbon/decorators/button.dart';
import 'package:campus_carbon/decorators/text_field.dart';
import 'package:campus_carbon/decorators/pic_button.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTapRegister});

  final Function()? onTapRegister;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passController = TextEditingController();

  final passConfirmController = TextEditingController();

  void register() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Center(
              child: Lottie.asset('lib/assets/twodots.json',width:200,height:200),
            ),
          );
        });

    if (passController.text.trim() != passConfirmController.text.trim()) {
      wrongMessage("Passwords don't match!");
      return;
    }
    if (usernameController.text.isEmpty) {
      wrongMessage("Enter Name!");
      return;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      Navigator.pop(context);
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(usernameController.text.trim());

      // await FirebaseAuth.instance.signOut();

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongMessage(e.code);
    }
  }

  void wrongMessage(String msgDisplay) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Center(
                  child: Text(
            msgDisplay,
          )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                const SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.nature_people_sharp,
                  size: 80,
                  color: Colors.grey[1000],
                ),
                const SizedBox(
                  height: 20,
                ),
                //text
                Text(
                  "Register Now!",
                  style: TextStyle(color: Colors.grey[900], fontSize: 18),
                ),
                const SizedBox(
                  height: 25,
                ),
                //Input
                MyTextField(
                  controller: usernameController,
                  hintText: "Name",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                //Pas
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passConfirmController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                //Forgot

                const SizedBox(height: 10),

                //Login
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  strValue: "Register",
                  onTap: register,
                ),
                //Register

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTapRegister,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 35),
                //Continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    PicButton(imagePath: "lib/assets/images/google.png"),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
