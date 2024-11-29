import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

import 'api_service.dart';

class AQIPage extends StatefulWidget {
  const AQIPage({super.key});

  @override
  _AQIPageState createState() => _AQIPageState();
}

class _AQIPageState extends State<AQIPage> {
  late Future<Map<String, dynamic>?> aqiData;
  final ApiService apiService = ApiService();

  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    _getLocationAndFetchAQI();
  }

  Future<void> _getLocationAndFetchAQI() async {
    try {
      // Check location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Cannot fetch location.');
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;

      // Fetch AQI data
      setState(() {
        aqiData = apiService.fetchAQI(lat: latitude, lon: longitude);
      });
    } catch (e) {
      // Handle errors
      setState(() {
        aqiData = Future.error(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text(
          'Air Around Me',
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<Map<String, dynamic>?>(
              future: aqiData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!;
                  final aqi = data['list'][0]['main']['aqi'];
                  final components = data['list'][0]['components'];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Air Quality Index Monitoring",
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: _getAQIColor(aqi),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'AQI Level: $aqi',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _getAQIDescription(aqi),
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Pollutant Levels (µg/m³)",
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...components.entries.map((entry) {
                        final limitExceeded = _isLimitExceeded(entry.key, entry.value);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${entry.key.toUpperCase()}: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: limitExceeded ? Colors.red : Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: limitExceeded
                                    ? BoxDecoration(
                                        color: Colors.red[100],
                                        borderRadius: BorderRadius.circular(5),
                                      )
                                    : null,
                                child: Text(
                                  '${entry.value}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: limitExceeded ? FontWeight.bold : FontWeight.normal,
                                    color: limitExceeded ? Colors.red[900] : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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

  String _getAQIDescription(int aqi) {
    switch (aqi) {
      case 1:
        return "Excellent";
      case 2:
        return "Good";
      case 3:
        return "Fair";
      case 4:
        return "Moderate";
      case 5:
        return "Poor";
      default:
        return "Unknown";
    }
  }

  Color _getAQIColor(int aqi) {
    switch (aqi) {
      case 1:
        return Colors.green[400]!;
      case 2:
        return Colors.lightGreen[600]!;
      case 3:
        return Colors.yellow[700]!;
      case 4:
        return Colors.orange[800]!;
      case 5:
        return Colors.red[900]!;
      default:
        return Colors.grey;
    }
  }

  bool _isLimitExceeded(String pollutant, dynamic value) {
    const limits = {
      'so2': 350,
      'no2': 200,
      'pm10': 200,
      'pm2_5': 75,
      'o3': 180,
      'co': 15400,
    };

    if (limits.containsKey(pollutant)) {
      return value > limits[pollutant]!;
    }
    return false;
  }
}
