// representatives_users_page.dart

import 'package:flutter/material.dart';

class RepresentativesUsersPage extends StatelessWidget {
  const RepresentativesUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.teal[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Representatives Information",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Table(
                border: TableBorder.all(color: Colors.teal[800]!, width: 1),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.teal[800]),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "User Type",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Average Electricity Consumption",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Accuracy",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // List of user types with placeholders
                  _buildTableRow("Btech Male"),
                  _buildTableRow("Btech Female"),
                  _buildTableRow("Mtech Male"),
                  _buildTableRow("Mtech Female"),
                  _buildTableRow("PhD Male"),
                  _buildTableRow("PhD Female"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String userType) {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.white), // Set row background to white
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            userType,
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "0W",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "upto __%",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
