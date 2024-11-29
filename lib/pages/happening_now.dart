import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON data
import 'add_data_screen.dart'; // Make sure to import the AddDataScreen

class HappeningNowPage extends StatefulWidget {
  const HappeningNowPage({super.key});

  @override
  _HappeningNowPageState createState() => _HappeningNowPageState();
}

class _HappeningNowPageState extends State<HappeningNowPage> {
  List<dynamic> updates = [];

  // Function to fetch data from the server
  Future<void> fetchUpdates() async {
    try {
      var response = await http
          .get(Uri.parse('https://dpbackend-jf4z.onrender.com/coordinates'));

      if (response.statusCode == 200) {
        // Parse the JSON data
        List<dynamic> data = json.decode(response.body);

        setState(() {
          updates = data; // Store the fetched data
        });

        // Auto-remove the first update after 20 seconds
        Future.delayed(Duration(seconds: 20), () {
          if (mounted && updates.isNotEmpty) {
            setState(() {
              updates.removeAt(0); // Remove the first update after 20 seconds
            });
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle errors such as no network or invalid response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching updates: $error')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUpdates(); // Fetch data when the page loads
  }

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
              child: ListView.builder(
                itemCount: updates.length,
                itemBuilder: (context, index) {
                  var update = updates[index];
                  return Dismissible(
                    key: Key(update['placeDescription'] ??
                        'No Title'), // Unique key for each item
                    onDismissed: (direction) {
                      // Remove the item when swiped
                      setState(() {
                        updates.removeAt(index);
                      });

                      // Show a snackbar when item is dismissed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Item dismissed")),
                      );
                    },
                    direction:
                        DismissDirection.endToStart, // Swipe from right to left
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white, size: 40),
                    ),
                    child: _buildUpdateCard(
                      title: update['placeDescription'] ?? 'No Title',
                      description: update['description'] ?? 'No Description',
                      color: _getCardColor(index),
                    ),
                  );
                },
              ),
            ),
            // Add the "Add Data" button here with gradient background
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to AddDataScreen when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDataScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(5),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal[800]!, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: double.infinity, minHeight: 50),
                      alignment: Alignment.center,
                      child: Text(
                        "Report an Issue",
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to determine a random background color for each card
  Color _getCardColor(int index) {
    List<Color> colors = [
      Colors.orange[800]!,
      Colors.red[800]!,
      Colors.green[800]!,
      Colors.blue[800]!,
      Colors.purple[800]!,
    ];
    return colors[index % colors.length];
  }

  // Method to build a single update card
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
