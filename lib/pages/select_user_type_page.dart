import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../decorators/bigbutton.dart';
import 'faculty_car_usage_page.dart';
import 'student_car_usage_page.dart';

class SelectUserTypePage extends StatelessWidget {
  static const String description = 
    "Welcome! This interface enables different users to access and record transportation data, "
    "analyze infrastructure facilities, provide improvement suggestions, and generate summary reports. "
    "Choose the appropriate option to proceed.";

  const SelectUserTypePage({Key? key}) : super(key: key);

  void _navigate(BuildContext context, String destination) {
    if (destination == "FacultyLogin") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FacultyCarUsagePage()),
      );
    } else if (destination == "StudentLogin") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentCarUsagePage()),
      );
    } else {
      // Temporary SnackBar for remaining options
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feature "$destination" coming soon!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Access Panel")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: GoogleFonts.mulish(fontSize: 16),
            ),
            const SizedBox(height: 32),
            MyBigButton(
              startColor: Colors.indigo[700],
              endColor: Colors.blue[400],
              onTap: () => _navigate(context, "FacultyLogin"),
              strValue: "Faculty Login",
            ),
            const SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.green[700],
              endColor: Colors.lightGreen[400],
              onTap: () => _navigate(context, "StudentLogin"),
              strValue: "Student Login",
            ),
            const SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.deepPurple[700],
              endColor: Colors.purpleAccent[400],
              onTap: () => _navigate(context, "Infrastructure Analysis"),
              strValue: "Infrastructure Analysis",
            ),
            const SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.orange[700],
              endColor: Colors.deepOrange[300],
              onTap: () => _navigate(context, "Suggestions"),
              strValue: "Suggestions",
            ),
            const SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.teal[700],
              endColor: Colors.cyan[400],
              onTap: () => _navigate(context, "Report Generation"),
              strValue: "Report Generation",
            ),
          ],
        ),
      ),
    );
  }
}
