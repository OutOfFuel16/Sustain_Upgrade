import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../decorators/bigbutton.dart';
import 'ndvi_result_page.dart';

class GreenCoverPage extends StatefulWidget {
  const GreenCoverPage({super.key});

  @override
  _GreenCoverPageState createState() => _GreenCoverPageState();
}

class _GreenCoverPageState extends State<GreenCoverPage> {
  final _formKey = GlobalKey<FormState>();
  final _collegeCtrl = TextEditingController();

  void _analyze() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NdviResultPage(collegeName: _collegeCtrl.text.trim()),
        ),
      );
    }
  }

  @override
  void dispose() {
    _collegeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vegetation Analysis")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Analyse the vegetation and green cover of your campus and get suggestions to increase green cover.",
              style: GoogleFonts.mulish(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _collegeCtrl,
                decoration: const InputDecoration(
                  labelText: "Enter College Name",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? "Enter your college name" : null,
              ),
            ),
            const SizedBox(height: 24),
            MyBigButton(
              startColor: Colors.green[700],
              endColor: Colors.lightGreen[400],
              onTap: _analyze,
              strValue: "Analyse NDVI",
            ),
          ],
        ),
      ),
    );
  }
}
