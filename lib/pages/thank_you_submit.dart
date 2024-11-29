import 'package:flutter/material.dart';
import "map.dart";

class ThankYouScreen extends StatelessWidget {
  final Function onViewMapClick;

  ThankYouScreen({required this.onViewMapClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank you for submitting your data!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: 20),
              // Text(
              //   'Click below to view the changes on the map.',
              //   style: TextStyle(fontSize: 16),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(height: 30),
              // ElevatedButton(
              //   onPressed: () {
              //     // Navigate to the map screen directly and remove the ThankYouScreen from the stack
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             CollegeMap(), // Your map screen widget
              //       ),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.deepPurple,
              //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //   ),
              //   child: Text('Go to Map'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
