import 'dart:convert';

import 'package:campus_carbon/decorators/bigbutton.dart';
import 'package:campus_carbon/pages/home_page_data.dart';
import 'package:campus_carbon/pages/remote_xy_webpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campus_carbon/pages/user_data_display.dart';
import 'package:campus_carbon/pages/basic_calculator.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../keys/urls.dart';
import 'chatter_page.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  late PageController _myPageController;
  final user = FirebaseAuth.instance.currentUser!;

  final textToSentController = TextEditingController();

  late Future jsonData;

  _getData(String email, BuildContext context) async {
    String apiUrl = '${UrlConstants.apiUrl}/get-data?email=$email';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    return "";
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _myPageController = PageController();
    jsonData = _getData(user.email ?? "NA", context);
  }

  @override
  void dispose() {
    _myPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.teal[900],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey[300],
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatterPage()));
            },
            child: Lottie.asset('lib/assets/bot.json'),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: const IconThemeData(color: Colors.white70),
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: signOut,
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white70,
                      )),
                ],
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 45,
                          child: DefaultTextStyle(
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    letterSpacing: 3,
                                    fontSize: 30,
                                    color: Colors.teal[100])),
                            child: AnimatedTextKit(
                              pause: const Duration(milliseconds: 150),
                              repeatForever: true,
                              animatedTexts: [
                                RotateAnimatedText('  Welcome, '),
                                RotateAnimatedText('  Namaste, '),
                                RotateAnimatedText('  Hello, '),
                                RotateAnimatedText('  Greetings, '),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          textAlign: TextAlign.right,
                          " ${user.displayName ?? 'User'}",
                          style: GoogleFonts.mulish(
                              textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: height / 1.2,
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
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "Real-Time Electricity Monitoring, Smart Switch Usage and Carbon footprint.",
                                  style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                                future: jsonData,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String data = snapshot.data.toString();
                                    if (data == '{"data":null}') {
                                      return Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "-Start Tracking-",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.green[900],
                                          ),
                                        ),
                                      );
                                    }
                                    final Map<String, dynamic> parsedJson =
                                        jsonDecode(data);
                                    final carbonData =
                                        CarbonData.fromJson(parsedJson['data']);
                                    final latestCarbonData =
                                        findLatest(carbonData);
                                    final totalEmission = (latestCarbonData[
                                            'power'] +
                                        latestCarbonData['vehicle'] +
                                        latestCarbonData['publicTransport'] +
                                        latestCarbonData['flight'] +
                                        latestCarbonData['food'] +
                                        latestCarbonData['secondary']);

                                    return HomePageData(
                                        latestCarbonData: latestCarbonData,
                                        totalEmission: totalEmission);
                                  } else {
                                    return Center(
                                      child: Lottie.asset(
                                          'lib/assets/twodots.json',
                                          width: 200,
                                          height: 200),
                                    );
                                  }
                                }),
                            const SizedBox(
                              height: 40,
                            ),
                            // Updated button order
                            MyBigButton(
                                animationPath: 'lib/assets/electricity.json',
                                startColor: Colors.blueGrey[900],
                                endColor: Colors.lightGreen[800],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebLinkPage()));
                                },
                                strValue: "Electricity"),
                            const SizedBox(
                              height: 20,
                            ),
                            MyBigButton(
                                animationPath:
                                    'lib/assets/basiccalculator.json',
                                startColor: Colors.blueGrey[900],
                                endColor: Colors.cyan[800],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BasicCalculator()));
                                },
                                strValue: "Carbon Emission Calculator"),
                            const SizedBox(
                              height: 20,
                            ),
                            MyBigButton(
                              // animationPath: 'lib/assets/water.json',
                              startColor: Colors.blue[900],
                              endColor: Colors.blueAccent[700],
                              onTap: () {
                                // TODO: Navigate to Water Consumption Page
                              },
                              strValue: "Water Consumption",
                            ),
                            const SizedBox(height: 20),

                          MyBigButton(
                              // animationPath: 'lib/assets/waste.json',
                              startColor: Colors.deepOrange[900],
                              endColor: Colors.orange[600],
                              onTap: () {
                                // TODO: Navigate to Waste Management Page
                              },
                              strValue: "Waste Management",
                            ),
                            const SizedBox(height: 20),

                          MyBigButton(
                              // animationPath: 'lib/assets/walk.json',
                              startColor: Colors.purple[400],
                              endColor: Colors.deepPurple[900],
                              onTap: () {
                                // TODO: Navigate to Walkability Page
                              },
                              strValue: "Walkability",
                            ),
                            const SizedBox(height: 20),

                            MyBigButton(
                              // animationPath: 'lib/assets/green_cover.json',
                              startColor: Colors.green[900],
                              endColor: Colors.lightGreen[600],
                              onTap: () {
                                // TODO: Navigate to Green Cover Page
                              },
                              strValue: "Green Cover",
                            ),
                            const SizedBox(height: 40),

                            // MyBigButton(
                            //     imagePath: 'lib/assets/images/previous.png',
                            //     startColor: Colors.blueGrey[900],
                            //     endColor: Colors.lightGreen[800],
                            //     onTap: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => UserData(
                            //                   email: user.email ?? "NA")));
                            //     },
                            //     strValue: "Get Previous Data"),
                            // const SizedBox(
                            //   height: 20,
                            // ),
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
}
