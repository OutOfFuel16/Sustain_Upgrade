import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    description: "This is a placeholder description. Replace it with real updates.",
                    color: Colors.orange[800]!,
                  ),
                  // Add more cards dynamically when updates are available.
                ],
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
