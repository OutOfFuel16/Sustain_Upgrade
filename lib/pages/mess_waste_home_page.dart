import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../decorators/bigbutton.dart';
import 'skip_meal_page.dart';
// import 'food_waste_analysis_page.dart'; // stub
import 'mess_suggestions_page.dart';

class MessWasteHomePage extends StatelessWidget {
  static const String description = 
    "Food is a fundamental human need, essential for survival, health, and energy. "
    "It supports physical growth, cognitive function, and overall well-being, making it "
    "critical for sustaining life and productivity. So it becomes necessary to avoid any "
    "kind of food wastage. To ensure food sustainability, remember the following points: "
    "Always take how much is required. Segregate the leftovers in different dustbins as "
    "veg-waste, non-veg waste, non-biodegradable waste (if any).";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mess Waste")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: GoogleFonts.mulish(fontSize: 16)),
            SizedBox(height: 32),
            MyBigButton(
              startColor: Colors.blue[700],
              endColor: Colors.lightBlue[400],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SkipMealPage()),
              ),
              strValue: "Skipping Meals",
            ),
            SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.red[700],
              endColor: Colors.redAccent[400],
              onTap: () {
                // TODO: implement your food waste analysis
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FoodWasteAnalysisPage()),
                );
              },
              strValue: "Food Waste Analysis",
            ),
            SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.green[700],
              endColor: Colors.lightGreen[400],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MessSuggestionsPage()),
              ),
              strValue: "Suggestions",
            ),
          ],
        ),
      ),
    );
  }
}

class FoodWasteAnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food Waste Analysis")),
      body: Center(
        child: Text(
          "Food Waste Analysis Page",
          style: GoogleFonts.mulish(fontSize: 18),
        ),
      ),
    );
  }
}
