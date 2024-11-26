import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'api_service.dart';

class AQIPage extends StatefulWidget {
  const AQIPage({super.key});

  @override
  _AQIPageState createState() => _AQIPageState();
}

class _AQIPageState extends State<AQIPage> {
  late Future<Map<String, dynamic>?> aqiData;
  final ApiService apiService = ApiService();

  // Replace with coordinates of any city in Himachal Pradesh
  final double latitude = 31.1048; // Example: Shimla latitude
  final double longitude = 77.1734; // Example: Shimla longitude

  @override
  void initState() {
    super.initState();
    // Fetch AQI data when the page is loaded
    aqiData = apiService.fetchAQI(lat: latitude, lon: longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[300],
        shape: const CircleBorder(),
        onPressed: () {
          // Action for floating button if needed
        },
        child: Lottie.asset('lib/assets/bot.json'), // Lottie animation asset
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text(
          'Air Around Me',
          style: GoogleFonts.mulish(
              textStyle: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 30,
                  fontWeight: FontWeight.w600)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FutureBuilder<Map<String, dynamic>?>(
              future: aqiData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error fetching AQI data.');
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!;
                  final aqi = data['list'][0]['main']['aqi'];
                  final components = data['list'][0]['components'];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Air Quality Index Monitoring",
                        style: GoogleFonts.mulish(
                            textStyle: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'AQI Level: $aqi',
                        style: GoogleFonts.mulish(
                            textStyle: const TextStyle(fontSize: 24)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LeafListItem(
                            heading: 'CO: ',
                            text: '${components['co']} µg/m³',
                          ),
                          LeafListItem(
                            heading: 'NO: ',
                            text: '${components['no']} µg/m³',
                          ),
                          LeafListItem(
                            heading: 'NO₂: ',
                            text: '${components['no2']} µg/m³',
                          ),
                          LeafListItem(
                            heading: 'O₃: ',
                            text: '${components['o3']} µg/m³',
                          ),
                          LeafListItem(
                            heading: 'PM10: ',
                            text: '${components['pm10']} µg/m³',
                          ),
                          LeafListItem(
                            heading: 'PM2.5: ',
                            text: '${components['pm2_5']} µg/m³',
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  );
                } else {
                  return const Text('No data available.');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LeafListItem extends StatelessWidget {
  final String heading;
  final String text;
  const LeafListItem({super.key, required this.heading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.eco,
              color: Colors.green[900],
            ),
            const SizedBox(width: 5),
            Flexible(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 18)),
                      children: <TextSpan>[
                    TextSpan(
                        text: heading,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: text)
                  ])),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
