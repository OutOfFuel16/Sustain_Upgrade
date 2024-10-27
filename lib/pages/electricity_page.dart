// lib/pages/electricity_page.dart

import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON responses
import 'package:http/http.dart' as http; // For making HTTP requests
import 'switch_detail_page.dart'; // Import your SwitchDetailPage

class ElectricityPage extends StatefulWidget {
  const ElectricityPage({Key? key}) : super(key: key);

  @override
  _ElectricityPageState createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
  // Define switch statuses and usage times
  bool switch1Status = false;
  bool switch2Status = false;
  bool switch3Status = false;
  bool switch4Status = false;

  String switch1UsageTime = "Loading...";
  String switch2UsageTime = "Loading...";
  String switch3UsageTime = "Loading...";
  String switch4UsageTime = "Loading...";

  // Function to fetch switch status and usage time from server
  Future<void> fetchSwitchStatus() async {
    try {
      // Replace with actual API URLs
      final response1 =
          await http.get(Uri.parse("YOUR_SERVER_API_URL/switch1"));
      final response2 =
          await http.get(Uri.parse("YOUR_SERVER_API_URL/switch2"));
      final response3 =
          await http.get(Uri.parse("YOUR_SERVER_API_URL/switch3"));
      final response4 =
          await http.get(Uri.parse("YOUR_SERVER_API_URL/switch4"));

      setState(() {
        // Assuming API response is JSON like: {"status": "on", "usageTime": "2 hours"}
        switch1Status = json.decode(response1.body)['status'] == 'on';
        switch1UsageTime = json.decode(response1.body)['usageTime'];

        switch2Status = json.decode(response2.body)['status'] == 'on';
        switch2UsageTime = json.decode(response2.body)['usageTime'];

        switch3Status = json.decode(response3.body)['status'] == 'on';
        switch3UsageTime = json.decode(response3.body)['usageTime'];

        switch4Status = json.decode(response4.body)['status'] == 'on';
        switch4UsageTime = json.decode(response4.body)['usageTime'];
      });
    } catch (error) {
      print("Error fetching switch status: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSwitchStatus();
  }

  // Function to create a switch button
  Widget buildSwitchButton(String switchName, bool status, String usageTime) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            status ? Colors.green : const Color.fromARGB(255, 196, 65, 56),
        minimumSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SwitchDetailPage(
              switchName: switchName,
              usageTime: usageTime,
            ),
          ),
        );
      },
      child: Text(
        switchName,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Electricity"),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            buildSwitchButton("Switch 1", switch1Status, switch1UsageTime),
            SizedBox(height: 30),
            buildSwitchButton("Switch 2", switch2Status, switch2UsageTime),
            SizedBox(height: 30),
            buildSwitchButton("Switch 3", switch3Status, switch3UsageTime),
            SizedBox(height: 30),
            buildSwitchButton("Switch 4", switch4Status, switch4UsageTime),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
