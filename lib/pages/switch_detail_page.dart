// lib/pages/switch_detail_page.dart

import 'package:flutter/material.dart';

class SwitchDetailPage extends StatelessWidget {
  final String switchName;
  final String usageTime;

  const SwitchDetailPage(
      {Key? key, required this.switchName, required this.usageTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(switchName),
        backgroundColor: Colors.teal[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Detailed usage information for $switchName:",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Usage Time: $usageTime",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
