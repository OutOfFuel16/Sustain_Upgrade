import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = '53a5a58a8ebf0d25df42326e968d48ab'; // Replace with your OpenWeatherMap API key
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/air_pollution';

  // Function to get AQI data for a city (by latitude and longitude)
  Future<Map<String, dynamic>?> fetchAQI({required double lat, required double lon}) async {
    final response = await http.get(Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
