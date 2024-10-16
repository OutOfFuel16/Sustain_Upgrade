import 'package:flutter/material.dart';
import 'package:campus_carbon/decorators/bigbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_carbon/pages/map.dart';
import 'package:campus_carbon/pages/add_data_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'chatter_page.dart';

class CollegePage extends StatefulWidget {
  const CollegePage({super.key});

  @override
  State<CollegePage> createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {
  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blueGrey[900],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey[300],

            shape: const CircleBorder(),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const ChatterPage()));
            },
            child: Lottie.asset('lib/assets/bot.json'),
          ),
          body: CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   //floating: true,
              //   backgroundColor: Colors.transparent,
              //   actions: [
              //     IconButton(
              //         onPressed: signOut,
              //         icon: const Icon(
              //           Icons.logout,
              //           color: Colors.white70,
              //         )),
              //   ],
              // ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'lib/assets/images/iit.jpeg',
                          height: MediaQuery.sizeOf(context).height * 0.23,
                          width: MediaQuery.sizeOf(context).width,
                          fit: BoxFit.cover,
      
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: height/1.2,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
      
                            Container(
                              //color: Colors.red,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "View and add info about IIT Mandi campus.",
                                  style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                )),
                            const SizedBox(
                              height: 40,
                            ),
      
                            MyBigButton(
                                //imagePath: "lib/assets/images/map.png",
                              animationPath:"lib/assets/map2.json" ,
                                startColor: Colors.blueGrey[900],
                                endColor: Colors.cyan[800],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CollegeMap()));
                                },
                                strValue: "Informative College Map"),
                            const SizedBox(
                              height: 20,
                            ),
                            MyBigButton(
                                //imagePath: "lib/assets/images/adddata.png",
                                animationPath: "lib/assets/add.json",
                                startColor: Colors.blueGrey[900],
                                endColor: Colors.green[700],
                                onTap: () => _addDataPage(user, context),
                                strValue: "Add Data"),
                            const SizedBox(
                              height: 200,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]))
            ],
          )),
    );
  }

  void _showResultDialog(String totalEmissions, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Status"),
          content: Text(totalEmissions),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  _addDataPage(user, BuildContext context) {
    if (user.email! == "a@eg.com") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddDataPage()));
    } else {
      _showResultDialog("Need Admin Privileges", context);
    }
  }
}
