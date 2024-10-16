// ignore_for_file: prefer_const_constructors

import 'package:campus_carbon/pages/about_page.dart';
import 'package:campus_carbon/pages/learn_page.dart';
import 'package:campus_carbon/pages/track_home_page.dart';
import 'package:campus_carbon/pages/trading_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'college_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _myPageController;
  final user = FirebaseAuth.instance.currentUser!;

  final textToSentController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _myPageController = PageController();
  }

  @override
  void dispose() {
    _myPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: GNav(
          //tabBackgroundGradient: LinearGradient(colors: [Colors.red,Colors.blue]),
          activeColor: Colors.grey[100]!,
          padding: EdgeInsets.only(left: 11,right: 11,top: 20,bottom: 20),
         tabMargin: EdgeInsets.only(top: 9,bottom: 13,),
          selectedIndex: _selectedIndex,
          textStyle: GoogleFonts.quicksand(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey[100])),
          gap: 8,
          tabBackgroundColor: Colors.teal[800]!,
          tabs:  [
            GButton(iconColor: Colors.grey[500],icon: Icons.person_2_outlined, text: 'Individual',),
            GButton(iconColor: Colors.grey[500],icon: Icons.account_balance_outlined, text: 'College'),
            GButton(iconColor: Colors.grey[500],icon: CupertinoIcons.lightbulb, text: 'Learn'),
            GButton(iconColor: Colors.grey[500],icon: Icons.co2, text: 'Offset',iconSize: 33,),
            GButton(iconColor: Colors.grey[500],icon: Icons.info_outlined, text: 'About',),

          ],
          onTabChange: (index) {
            _myPageController.jumpToPage(index);
          },
        ),
        backgroundColor: Colors.teal[900],
        body: PageView(
          controller: _myPageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [TrackPage(), CollegePage(), LearnPage(),TradingPage(),AboutPage()],
        ));
  }
}
