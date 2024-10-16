
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campus_carbon/decorators/button.dart';
import 'package:campus_carbon/decorators/text_field.dart';
import 'package:campus_carbon/decorators/pic_button.dart';
import 'package:lottie/lottie.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTapRegister});

  final Function()? onTapRegister;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController=TextEditingController();

  final passController=TextEditingController();

  //User Sign In
  void signIn() async {


    //loading
    showDialog(
        context: context,
        builder: (context){
          return Center(
            child: Lottie.asset('lib/assets/twodots.json',width:200,height:200),
          );
        }
    );

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passController.text.trim(),
      );
      Navigator.of(context).pop();
    }

    on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();

      wrongMessage(e.code);

    }

  }

  void wrongMessage(String msgDisplay) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Center(
              child: Text(
                msgDisplay,
              )
            )
          );
        }
    );
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
                const SizedBox(height: 50,),
                Icon(
                  Icons.nature_people_sharp,
                  size: 120,
                  color: Colors.grey[1000],
                ),
                const SizedBox(height: 50,),
                //text
                Text(
                  "Welcome back!",
                  style: TextStyle(
                      color: Colors.grey[900],
                    fontSize: 18
                  ),
                ),
                const SizedBox(height: 25,),
                //Input
                MyTextField(
                    controller: usernameController,
                    hintText: "Email",
                    obscureText: false,
                ),
                //Pass
                const SizedBox(height: 10,),
                MyTextField(
                  controller: passController,
                  hintText: "Password",
                  obscureText: true,
                ),


                //Forgot

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),



                //Login
                const SizedBox(height: 25,),
                MyButton(
                  strValue: "Sign In",
                    onTap: signIn,
                ),
                //Register

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTapRegister,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )

                  ],
                ),


                const SizedBox(height: 50),
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

                const SizedBox(height: 50),

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
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
