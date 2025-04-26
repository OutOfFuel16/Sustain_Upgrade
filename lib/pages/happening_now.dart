import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON data
import 'package:intl/intl.dart'; // For formatting dates
import 'add_data_screen.dart'; // Ensure AddDataScreen is imported

class HappeningNowPage extends StatefulWidget {
  const HappeningNowPage({super.key});

  @override
  _HappeningNowPageState createState() => _HappeningNowPageState();
}

class _HappeningNowPageState extends State<HappeningNowPage> {
  List<dynamic> updates = [];

  // Create a mapping between categories and colors
  final Map<String, Color> categoryColors = {
    'Academic Block': const Color.fromARGB(255, 8, 48, 94),
    'Hostel': const Color.fromARGB(255, 77, 167, 200),
    'Green Area': Colors.teal[800]!,
    'Faculty Quarters': Colors.purple[800]!,
    'Mess': Colors.orange[800]!,
    'Store': Colors.red[800]!,
    'Canteen': Colors.yellow[800]!,
  };

  // Function to fetch data from the server
  Future<void> fetchUpdates() async {
    try {
      var response = await http
          .get(Uri.parse('https://dpbackend-jf4z.onrender.com/coordinates'));

      if (response.statusCode == 200) {
        // Parse the JSON data
        List<dynamic> data = json.decode(response.body);

        // Sort the updates based on the createdAt date in descending order
        data.sort((a, b) {
          DateTime dateA = DateTime.parse(a['createdAt']);
          DateTime dateB = DateTime.parse(b['createdAt']);
          return dateB.compareTo(dateA); // Descending order
        });

        setState(() {
          updates = data; // Store the fetched data
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

  // Function to resolve an issue (removes it from database)
  Future<void> resolveIssue(String id, int index) async {
    try {
      var response = await http.delete(
        Uri.parse('https://dpbackend-jf4z.onrender.com/coordinates/$id'),
      );

      if (response.statusCode == 200) {
        // Remove the item from the list if resolved successfully
        setState(() {
          updates.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Issue resolved successfully')),
        );
      } else {
        throw Exception('Failed to resolve issue');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error resolving issue: $error')),
      );
    }
  }

  // Function to parse placeDescription and extract category, location, and issue
  Map<String, String> parsePlaceDescription(String placeDescription) {
    // Regular expression to match Category, Location, and Issue
    RegExp categoryRegExp = RegExp(r'Category:\s*([A-Za-z0-9\s]+)');
    RegExp locationRegExp = RegExp(r'Location:\s*([A-Za-z0-9\s]+)');
    RegExp issueRegExp = RegExp(r'Issue:\s*([A-Za-z0-9\s]+)');

    // Extract values using regex
    String category =
        categoryRegExp.firstMatch(placeDescription)?.group(1) ?? 'No Category';
    String location =
        locationRegExp.firstMatch(placeDescription)?.group(1) ?? 'No Location';
    String issue =
        issueRegExp.firstMatch(placeDescription)?.group(1) ?? 'No Issue';

    return {
      'category': category,
      'location': location,
      'issue': issue,
    };
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

                  // Parse the placeDescription to extract Category, Location, and Issue
                  Map<String, String> placeData =
                      parsePlaceDescription(update['placeDescription']);
                  String category = placeData['category'] ?? 'No Category';
                  String location = placeData['location'] ?? 'No Location';
                  String issue = placeData['issue'] ?? 'No Issue';

                  // Extract the date and format it
                  String dateAdded =
                      update['createdAt'] ?? DateTime.now().toIso8601String();
                  DateTime createdAt = DateTime.parse(dateAdded);

// Convert to IST by adding 5 hours and 30 minutes to UTC time
                  DateTime istTime =
                      createdAt.add(const Duration(hours: 5, minutes: 30));

// Format the date as needed (using intl package)
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(istTime);
                  // Determine the background color for this category
                  Color categoryColor = categoryColors[category] ?? Colors.grey;

                  return _buildUpdateCard(
                    id: update['_id'] ?? 'No ID',
                    category: category,
                    location: location,
                    issue: issue,
                    dateAdded: formattedDate,
                    color: categoryColor,
                    index: index,
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
                        WidgetStateProperty.all(const Size(double.infinity, 50)),
                    padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                    elevation: WidgetStateProperty.all(5),
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
                      constraints: const BoxConstraints(
                          maxWidth: double.infinity, minHeight: 50),
                      alignment: Alignment.center,
                      child: Text(
                        "Report an Issue",
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
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

  // Method to build a single update card
  Widget _buildUpdateCard({
    required String id,
    required String category,
    required String location,
    required String issue,
    required String dateAdded,
    required Color color,
    required int index,
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
            _buildHighlightedText("Category", category, fontSize: 18),
            const SizedBox(height: 8),
            _buildHighlightedText("Location", location, fontSize: 18),
            const SizedBox(height: 8),
            _buildHighlightedText("Issue", issue, fontSize: 18),
            const SizedBox(height: 8),
            _buildHighlightedText("Date Added", dateAdded, fontSize: 18),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => resolveIssue(id, index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // White background
                  foregroundColor: Colors.teal[800], // Text color
                ),
                child: Text(
                  "Issue Resolved",
                  style: GoogleFonts.mulish(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  // Widget to build highlighted text with dynamic font size
  Widget _buildHighlightedText(String label, String value,
      {double fontSize = 16}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: GoogleFonts.mulish(
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.mulish(
              textStyle: TextStyle(
                fontSize: fontSize,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}