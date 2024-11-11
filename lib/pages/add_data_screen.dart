import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'locations.dart'; // Ensure this imports your locations.dart file

// Add the ThankYouScreen import
import 'thank_you_submit.dart'; // Import the Thank You screen
import "map.dart";

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  String _selectedCategory = '';
  String? _selectedSubcategory;
  String _userData = '';
  List<MapLatLng> selectedLocationCoords = [];

  final Map<String, List<List<MapLatLng>>> locationCategories = {
    'Academic': Academic,
    'Hostel': Hostels,
    'Green Area': green_area,
    'Staff': staff,
    'Messes': [],
    'Stores': [],
    'Canteens': [],
  };

  final Map<String, List<String>> subcategoryNames = {
    'Messes': ['Alder', 'Pine', 'Oak', 'Tulsi'],
    'Stores': ['Redstart', 'Megastar'],
    'Canteens': ['Monal', 'Drongo', 'Trago', 'One Bite'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select Location to Add Data:',
                style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _selectedCategory.isEmpty ? null : _selectedCategory,
              hint: Text('Select a Location Category'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _selectedSubcategory = null;
                  selectedLocationCoords.clear();

                  if (!subcategoryNames.containsKey(_selectedCategory)) {
                    selectedLocationCoords =
                        locationCategories[newValue]!.expand((e) => e).toList();
                  }
                });
              },
              items: locationCategories.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            SizedBox(height: 20),
            if (_selectedCategory.isNotEmpty &&
                subcategoryNames.containsKey(_selectedCategory))
              DropdownButton<String>(
                value: _selectedSubcategory,
                hint: Text('Select a specific location'),
                onChanged: (String? newSubcategory) {
                  setState(() {
                    _selectedSubcategory = newSubcategory;
                    if (newSubcategory != null) {
                      selectedLocationCoords =
                          _getLocationCoordinatesForSubcategory(newSubcategory);
                    }
                  });
                },
                items: subcategoryNames[_selectedCategory]!
                    .map<DropdownMenuItem<String>>((String subcategory) {
                  return DropdownMenuItem<String>(
                    value: subcategory,
                    child: Text(subcategory),
                  );
                }).toList(),
              ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _userData = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter your data (e.g., maintenance issue)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_userData.isNotEmpty && selectedLocationCoords.isNotEmpty) {
                  var coords = selectedLocationCoords.first;
                  double lat = coords.latitude;
                  double lng = coords.longitude;

                  // Navigate to the "Thank You" screen after submission
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThankYouScreen(
                        onViewMapClick: () {
                          // Navigate back to the map screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CollegeMap(), // Your Map screen widget
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: Text('Submit Data'),
            ),
          ],
        ),
      ),
    );
  }

  List<MapLatLng> _getLocationCoordinatesForSubcategory(
      String subcategoryName) {
    switch (subcategoryName) {
      case 'Alder':
        return mess_list[0];
      case 'Pine':
        return mess_list[1];
      case 'Oak':
        return mess_list[2];
      case 'Tulsi':
        return mess_list[3];
      case 'Redstart':
        return stores_list[0];
      case 'Megastar':
        return stores_list[1];
      case 'Monal':
        return canteens_list[0];
      case 'Drongo':
        return canteens_list[1];
      case 'Trago':
        return canteens_list[2];
      case 'One Bite':
        return canteens_list[3];
      default:
        return [];
    }
  }
}
