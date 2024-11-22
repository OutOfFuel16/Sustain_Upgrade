import 'package:flutter/material.dart';
import 'api_service.dart'; // Import the API service

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
      appBar: AppBar(
        title: const Text('Air Around Me'),
      ),
      body: Center(
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
                children: [
                  Text(
                    'AQI Level: $aqi',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'CO: ${components['co']} µg/m³\n'
                    'NO: ${components['no']} µg/m³\n'
                    'NO₂: ${components['no2']} µg/m³\n'
                    'O₃: ${components['o3']} µg/m³\n'
                    'PM10: ${components['pm10']} µg/m³\n'
                    'PM2.5: ${components['pm2_5']} µg/m³',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else {
              return const Text('No data available.');
            }
          },
        ),
      ),
    );
  }
}
