import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const ChatterPage()));
        },
        child: Lottie.asset('lib/assets/bot.json'),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text(
          'About EcoTrack',
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
                  "Welcome to EcoTrack, your all-in-one solution for monitoring and reducing carbon footprints at IIT Mandi!",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 40,),

                Text(
                  "Our Mission",
                  style: GoogleFonts.mulish(textStyle: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w600)),
                ),

                const SizedBox(height: 21,),

                Text(
                  "At EcoTrack, we are committed to fostering a culture of sustainability within the IIT Mandi community. Our mission is to empower individuals and organizations to track, understand, and minimize their carbon footprints, thereby contributing to a greener, more sustainable future.",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 40,),
                Text(
                  "Features",
                  style: GoogleFonts.mulish(textStyle: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w600)),
                ),

                const SizedBox(height: 21,),

                const LeafListItem(heading: 'Campus Carbon Footprint: ', text: "Explore detailed analytics on the carbon emissions of IIT Mandi, broken down by sources and departments. "),
                const LeafListItem(heading: 'Individual Carbon Calculator: ', text: 'Calculate your personal carbon footprint using our intuitive calculator tool. Discover how your lifestyle choices impact the environment and receive personalized tips for reducing your carbon footprint.'),
                const LeafListItem(heading: 'Educational Resources: ', text: 'Access a wealth of news articles and tips on sustainability, climate change, and eco-friendly living.'),

                const SizedBox(height: 26,),
                Text(
                  "Why EcoTrack?",
                  style: GoogleFonts.mulish(textStyle: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w600)),
                ),

                const SizedBox(height: 21,),

                Text('By using EcoTrack, you\'re not just monitoring carbon emissions – you\'re actively contributing to a sustainable future for our planet. Whether you\'re a student, faculty member, or staff at IIT Mandi, together, we can make a difference.',
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 18,),

                Text('Together, let\'s make every step count towards a sustainable future!',
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
  const LeafListItem({super.key,required this.heading,required this.text});

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Icon(Icons.eco_sharp,color: Colors.green[900],),
    //     Text(heading,style: GoogleFonts.quicksand(textStyle:const TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),),
    //     Flexible(child: Text(text,style: GoogleFonts.quicksand(textStyle:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500))))
    //   ],
    // );
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.eco,color: Colors.green[900],),
            Flexible(
              child: RichText(text: TextSpan(
                style: GoogleFonts.quicksand(textStyle:const TextStyle(color:Colors.black,fontSize: 18)),
                children: <TextSpan>[
                  TextSpan(text: heading,style: const TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: text)
                ]
              )),
            ),
          ],
        ),
        const SizedBox(height: 15,)
      ],
    );
  }
}

