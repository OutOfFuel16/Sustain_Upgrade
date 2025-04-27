import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../decorators/bigbutton.dart';
import 'mess_waste_home_page.dart';
import 'hostel_waste_home_page.dart';

class WasteManagementHomePage extends StatelessWidget {
  static const String description = 
    "Welcome, This interface enables real-time tracking and analysis of waste generated "
    "across campus hostels and mess facilities. Users can monitor waste segregation patterns, "
    "daily waste volumes, and identify high-generation zones. The goal is to support "
    "data-driven decisions for optimizing waste management and promoting sustainable practices.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waste Management")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: GoogleFonts.mulish(fontSize: 16),
            ),
            SizedBox(height: 32),
            MyBigButton(
              startColor: Colors.deepOrange[700],
              endColor: Colors.orange[400],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MessWasteHomePage()),
              ),
              strValue: "Mess Waste",
            ),
            SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.teal[700],
              endColor: Colors.lightGreen[400],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HostelWasteHomePage()),
              ),
              strValue: "Hostel Waste",
            ),
          ],
        ),
      ),
    );
  }
}
