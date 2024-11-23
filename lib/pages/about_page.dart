import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'chatter_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[300],
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatterPage()));
        },
        child: Lottie.asset('lib/assets/bot.json'),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text(
          'About SustainX',
          style: GoogleFonts.mulish(
              textStyle: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 30,
                  fontWeight: FontWeight.w600)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'lib/assets/images/logo.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome to SustainX, your all-in-one solution for  energy monitoring and sustainability at IIT Mandi!",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Our Mission",
                  style: GoogleFonts.mulish(
                      textStyle: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 21,
                ),
                Text(
                  "At SustainX, we aim to integrate sustainability into everyday campus life by reducing energy consumption, promoting eco-friendly practices, and offering a rewarding experience to all users. Our mission is to empower individuals to track their energy usage while fostering a culture of sustainability within the IIT Mandi community.",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Key Features",
                  style: GoogleFonts.mulish(
                      textStyle: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 21,
                ),
                const LeafListItem(
                    heading: 'Air Quality Index Monitoring: ',
                    text:
                        "Track and analyze the carbon emissions of IIT Mandi, broken down by departments and activitie."),
                const LeafListItem(
                    heading: 'Energy Consumption Monitoring: ',
                    text:
                        'Monitor and track energy consumption across campus to identify areas where sustainable practices can reduce carbon emissions.'),
                const LeafListItem(
                    heading: 'Carbon Footprint Calculator: ',
                    text:
                        'Use our easy-to-use carbon footprint calculator to understand your impact and receive personalized tips on how to reduce it.'),
                const LeafListItem(
                    heading: 'Educational Resources: ',
                    text:
                        'Stay up-to-date with articles, tips, and other resources to help you live a more sustainable life.'),
                const SizedBox(
                  height: 26,
                ),
                Text(
                  "Why SustainX?",
                  style: GoogleFonts.mulish(
                      textStyle: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 21,
                ),
                Text(
                  "By using SustainX, you're not just tracking your energy consumption – you're actively making a difference by contributing to a greener, more sustainable IIT Mandi. Whether you're a student, faculty member, or staff, together we can reduce our environmental impact and lead the change in sustainability.",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Join us in creating a sustainable future, one step at a time.",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeafListItem extends StatelessWidget {
  final String heading;
  final String text;
  const LeafListItem({super.key, required this.heading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.eco,
              color: Colors.green[900],
            ),
            Flexible(
              child: RichText(
                  text: TextSpan(
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 18)),
                      children: <TextSpan>[
                    TextSpan(
                        text: heading,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: text)
                  ])),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
