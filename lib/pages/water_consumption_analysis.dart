import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../decorators/bigbutton.dart';
import 'daily_supply_form_page.dart';
import 'maintainance_analysis_form_page.dart';

class WaterConsumptionAnalysisPage extends StatelessWidget {
  static const String description =
      "This interface helps monitor water supply, maintenance, and infrastructure analysis. "
      "Users can record daily supply data, report maintenance activities, and suggest improvements "
      "to ensure efficient water resource management.";

  const WaterConsumptionAnalysisPage({Key? key}) : super(key: key);

  void _navigate(BuildContext context, String destination) {
    if (destination == "DailySupplyAnalysis") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DailySupplyFormPage()),
      );
    } else if (destination == "MaintenanceAnalysis") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MaintenanceAnalysisFormPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feature "$destination" coming soon!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Water Consumption Analysis")),
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
              startColor: Colors.blue[900],
              endColor: Colors.blueAccent[400],
              onTap: () => _navigate(context, "DailySupplyAnalysis"),
              strValue: "Daily Supply Analysis",
            ),
            const SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.indigo[900],
              endColor: Colors.indigoAccent[400],
              onTap: () => _navigate(context, "MaintenanceAnalysis"),
              strValue: "Maintenance Analysis",
            ),
            const SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.cyan[700],
              endColor: Colors.cyanAccent[400],
              onTap: () => _navigate(context, "Report Generation"),
              strValue: "Report Generation",
            ),
            const SizedBox(height: 20),
            MyBigButton(
              startColor: Colors.teal[700],
              endColor: Colors.lightBlueAccent[400],
              onTap: () => _navigate(context, "Suggestions"),
              strValue: "Suggestions",
            ),
          ],
        ),
      ),
    );
  }
}
