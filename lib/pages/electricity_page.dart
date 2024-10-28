import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'switch_detail_page.dart'; // Import the SwitchDetailPage

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

  String switch1UsageTime = "Off";
  String switch2UsageTime = "Off";
  String switch3UsageTime = "Off";
  String switch4UsageTime = "Off";

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
        switch1Status = json.decode(response1.body)['status'] == 'on';
        switch1UsageTime = switch1Status ? "On" : "Off";

        switch2Status = json.decode(response2.body)['status'] == 'on';
        switch2UsageTime = switch2Status ? "On" : "Off";

        switch3Status = json.decode(response3.body)['status'] == 'on';
        switch3UsageTime = switch3Status ? "On" : "Off";

        switch4Status = json.decode(response4.body)['status'] == 'on';
        switch4UsageTime = switch4Status ? "On" : "Off";
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

  // Function to create a switch button with a slider
  Widget buildSwitchButton(String switchName, bool status, String usageTime) {
    return GestureDetector(
      // Wrap with GestureDetector
      onTap: () {
        // Navigate to the SwitchDetailPage when the switch button is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SwitchDetailPage(
              switchName: switchName,
              usageTime: status ? "On" : "Off", // Pass updated usage time
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200], // Neutral background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              switchName,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Row(
              children: [
                Text(
                  usageTime,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(width: 10),
                Switch(
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      // Update switch status
                      if (switchName == "Switch 1") {
                        switch1Status = value;
                        switch1UsageTime = switch1Status ? "On" : "Off";
                      } else if (switchName == "Switch 2") {
                        switch2Status = value;
                        switch2UsageTime = switch2Status ? "On" : "Off";
                      } else if (switchName == "Switch 3") {
                        switch3Status = value;
                        switch3UsageTime = switch3Status ? "On" : "Off";
                      } else if (switchName == "Switch 4") {
                        switch4Status = value;
                        switch4UsageTime = switch4Status ? "On" : "Off";
                      }
                    });
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                ),
              ],
            ),
          ],
        ),
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
            buildSwitchButton("Switch 1", switch1Status, switch1UsageTime),
            buildSwitchButton("Switch 2", switch2Status, switch2UsageTime),
            buildSwitchButton("Switch 3", switch3Status, switch3UsageTime),
            buildSwitchButton("Switch 4", switch4Status, switch4UsageTime),
          ],
        ),
      ),
    );
  }
}
