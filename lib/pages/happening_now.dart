import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_data_screen.dart'; // Make sure to import the AddDataScreen

class HappeningNowPage extends StatelessWidget {
  const HappeningNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text(
          'Happening Now',
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              color: Colors.grey[200],
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Events & Updates",
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  // Add updates dynamically here.
                  _buildUpdateCard(
                    title: "Example Event",
                    description:
                        "This is a placeholder description. Replace it with real updates.",
                    color: Colors.orange[800]!,
                  ),
                  // Add more cards dynamically when updates are available.
                ],
              ),
            ),
            // Add the "Add Data" button here with gradient background
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20), // Padding for the button from the bottom
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to AddDataScreen when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddDataScreen(), // Navigate to the AddDataScreen
                      ),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(double.infinity,
                        50)), // Button width to take full space
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors
                        .transparent), // Transparent background for the gradient
                    elevation: MaterialStateProperty.all(5),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal[800]!, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: double.infinity, minHeight: 50),
                      alignment: Alignment.center,
                      child: Text(
                        "Report an Issue",
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateCard({
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
