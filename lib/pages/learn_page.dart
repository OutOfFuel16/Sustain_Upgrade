import 'package:campus_carbon/pages/chatter_page.dart';
import 'package:campus_carbon/pages/recommendations.dart';
import 'package:flutter/material.dart';
import 'package:campus_carbon/decorators/bigbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'news_page.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
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
          backgroundColor: Colors.blueGrey[800],
          body: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'lib/assets/images/learn.jpeg',
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
                                      "Explore environmental news and sustainability tips for reducing Carbon Footprint.",
                                      style: GoogleFonts.quicksand(
                                          textStyle: const TextStyle(fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    )),
      
                                const SizedBox(height: 40,),
                                MyBigButton(
                                  //imagePath: "lib/assets/images/news.png",
                                    animationPath: 'lib/assets/bot.json',


                                    startColor: Colors.blueGrey[900],
                                    endColor: Colors.cyan[800],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ChatterPage()));
                                    },
                                    strValue: "EcoAI"),

                                const SizedBox(height: 20,),
                                MyBigButton(
                                  //imagePath: "lib/assets/images/news.png",
                                    animationPath: 'lib/assets/bulb2.json',


                                    startColor: Colors.blueGrey[900],
                                    endColor: Colors.lightGreen[800],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const RecommendationsPage()));
                                    },
                                    strValue: "Recommendations"),
                                const SizedBox(height: 20,),

                                MyBigButton(
                                  //imagePath: "lib/assets/images/news.png",
                                    animationPath: 'lib/assets/news.json',


                                    startColor: Colors.blueGrey[900],
                                    endColor: Colors.teal[500],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const NewsPage()));
                                    },
                                    strValue: "Related News"),



      
                                const SizedBox(height: 300,),
      
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]))
            ],
          )
      
      ),
    );
  }
}
