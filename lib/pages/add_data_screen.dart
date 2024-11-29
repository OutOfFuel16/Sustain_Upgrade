import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http; // For making HTTP requests
import 'thank_you_submit.dart'; // Import the Thank You screen
import 'map.dart'; // Import the map screen

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  String _selectedCategory = '';
  String _specificLocation = '';
  String _issueDescription = '';

  final List<String> categories = [
    'Academic',
    'Hostel',
    'Green Area',
    'Staff',
    'Mess',
    'Store',
    'Canteen'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.add_location_alt, color: Colors.white),
            SizedBox(width: 8),
            Text('Report an Issue'),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'Add Maintenance Data',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please provide details about any maintenance issues such as no water, food shortages, or emergencies like fire.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              SizedBox(height: 24),

              // Dropdown for selecting a category
              Text(
                'Select Location Category:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                  value: _selectedCategory.isEmpty ? null : _selectedCategory,
                  hint: Text('Select a Location Category'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              // TextField for specific location
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _specificLocation = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Specific Location (e.g., Room 101)',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // TextField for issue description
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _issueDescription = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Issue Description',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit button with gradient
              GestureDetector(
                onTap: () async {
                  if (_selectedCategory.isNotEmpty &&
                      _specificLocation.isNotEmpty &&
                      _issueDescription.isNotEmpty) {
                    // Prepare the combined description
                    String placeDescription =
                        'Category: $_selectedCategory, Location: $_specificLocation, Issue: $_issueDescription';

                    // Prepare data to send to the backend
                    var data = {'placeDescription': placeDescription};

                    try {
                      // Replace '<your_machine_ip>' with your machine's IP address
                      var response = await http.post(
                        Uri.parse(
                            'http://127.0.0.1:3000/coordinates'), // Add backend URL here
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode(data),
                      );

                      if (response.statusCode == 201) {
                        // Navigate to the Thank You screen on success
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThankYouScreen(
                              onViewMapClick: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CollegeMap(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        // Show an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Failed to submit data: ${response.body}'),
                          ),
                        );
                      }
                    } catch (error) {
                      // Show a snackbar for network or unexpected errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    }
                  } else {
                    // Prompt the user to fill in all fields
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade600, Colors.blue.shade400],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Submit Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
