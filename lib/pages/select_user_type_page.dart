import 'package:flutter/material.dart';
import 'package:campus_carbon/pages/faculty_car_usage_page.dart';
import 'package:campus_carbon/pages/student_car_usage_page.dart';

class SelectUserTypePage extends StatelessWidget {
  const SelectUserTypePage({Key? key}) : super(key: key);

  void _navigate(BuildContext context, String userType) {
    if (userType == "Faculty") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FacultyCarUsagePage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentCarUsagePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select User Type')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please select your user type:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _navigate(context, "Faculty"),
              child: Text("Faculty"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigate(context, "Student"),
              child: Text("Student"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
