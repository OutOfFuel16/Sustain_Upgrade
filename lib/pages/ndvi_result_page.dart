import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart'; // Make sure UrlConstants.ndviApi is set to your Cloud Function endpoint

class NdviResultPage extends StatefulWidget {
  final String collegeName;
  const NdviResultPage({super.key, required this.collegeName});

  @override
  _NdviResultPageState createState() => _NdviResultPageState();
}

class _NdviResultPageState extends State<NdviResultPage> {
  double? _ndvi;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchNdvi();
  }

  Future<void> _fetchNdvi() async {
    try {
      final uri = Uri.parse(
        '${UrlConstants.ndviApi}?college=${Uri.encodeComponent(widget.collegeName)}',
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _ndvi = (data['ndvi'] as num).toDouble();
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Server error: ${response.statusCode}';
          _loading = false;
        });
      } 
    } catch (e) {
      setState(() {
        _error = 'Error fetching NDVI: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NDVI Results")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: GoogleFonts.mulish(fontSize: 16, color: Colors.red),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NDVI for ${widget.collegeName}",
                        style: GoogleFonts.mulish(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "The Normalised Difference Vegetation Index (NDVI) is an indicator of vegetation health and density. "
                        "It ranges from -1.0 to 1.0, with values below 0 indicating non-vegetated surfaces and values above 0 indicating vegetated areas.",
                        style: GoogleFonts.mulish(fontSize: 14),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "🌱 Mean NDVI: ${_ndvi!.toStringAsFixed(2)}",
                        style: GoogleFonts.mulish(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      if (_ndvi! < 0.5) ...[
                        Text(
                          "⚠️ There is a possible scope of improvement.",
                          style: GoogleFonts.mulish(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Suggestions to improve NDVI:",
                          style: GoogleFonts.mulish(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "- Plant native tree species\n"
                          "- Increase green corridors\n"
                          "- Implement rooftop gardens\n"
                          "- Organize community tree-planting drives",
                          style: GoogleFonts.mulish(fontSize: 14),
                        ),
                      ] else ...[
                        Text(
                          "✅ There is decent green cover present at your campus.",
                          style: GoogleFonts.mulish(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Still, you can further enhance vegetation:",
                          style: GoogleFonts.mulish(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "- Introduce seasonal flowering plants\n"
                          "- Develop shaded walkways\n"
                          "- Create community gardens\n"
                          "- Expand green roof areas",
                          style: GoogleFonts.mulish(fontSize: 14),
                        ),
                      ],
                    ],
                  ),
                ),
    );
  }
}
