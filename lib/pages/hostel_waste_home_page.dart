import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../decorators/bigbutton.dart';
import 'report_violation_page.dart';
import 'hostel_suggestions_page.dart';

class HostelWasteHomePage extends StatelessWidget {
  static const String description = 
    "Effective waste segregation is crucial for a cleaner campus and a healthier environment. "
    "Proper sorting of biodegradable, recyclable, and hazardous waste ensures responsible disposal, "
    "promotes sustainability, and builds a culture of environmental stewardship. “Sort smart, live clean.”";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hostel Waste")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(description, style: GoogleFonts.mulish(fontSize: 16)),
          SizedBox(height: 32),
          MyBigButton(
            startColor: Colors.red[700],
            endColor: Colors.redAccent[400],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ReportViolationPage()),
            ),
            strValue: "Report Violation",
          ),
          SizedBox(height: 20),
          MyBigButton(
            startColor: Colors.green[700],
            endColor: Colors.lightGreen[400],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HostelSuggestionsPage()),
            ),
            strValue: "Suggestions",
          ),
          SizedBox(height: 20),
          MyBigButton(
            startColor: Colors.blue[700],
            endColor: Colors.lightBlue[400],
            onTap: () {
              // TODO: add analysis page
            },
            strValue: "Analysis",
          ),
        ]),
      ),
    );
  }
}

class HostelSuggestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hostel Suggestions")),
      body: Center(child: Text("Suggestions Page Content")),
    );
  }
}
