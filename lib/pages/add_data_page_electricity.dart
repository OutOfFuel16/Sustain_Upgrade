import 'package:campus_carbon/decorators/button.dart';
import 'package:campus_carbon/decorators/text_field.dart';
import 'package:campus_carbon/keys/urls.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class AddDataPageElectricity extends StatefulWidget {
  const AddDataPageElectricity({super.key});

  @override
  State<AddDataPageElectricity> createState() => _AddDataPageElectricityState();
}

class _AddDataPageElectricityState extends State<AddDataPageElectricity> {
  int numText = 3; //No. of text fields

  late List<TextEditingController> _controllers;

  void _sendData(values, BuildContext context) async {
    const String apiUrl =
        '${UrlConstants.apiUrl}/campus/save-data/electricity';

    List<dynamic> data = values.map((value) {
      if (value is DateTime) {
        return value.toIso8601String();
      } else {
        return value;
      }
    }).toList();

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'location': 'Electricity',
        'Value': data,
      }),
    );

    if (response.statusCode == 200) {
      _showResultDialog("Data sent successfully", context);
    } else {
      _showResultDialog(
          "Failed to send data. Error: ${response.statusCode}", context);
    }
  }

  void _showResultDialog(String totalEmissions, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Status"),
          content: Text(totalEmissions),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  void _saveData(
      List<TextEditingController> controllers, BuildContext context) {
    List<double> values = [];
    List values2 = [];
    List<DateTime> dates = [];

    dates.add(DateTime.parse(controllers[0].text));
    dates.add(DateTime.parse(controllers[1].text));

    Duration difference = dates[1].difference(dates[0]);
    // Calculate the number of days
    int days = difference.inDays + 1;

    String text = controllers[2].text.trim();
    if (text.isNotEmpty) {
      try {
        double value = double.parse(text);
        values.add(value);
      } catch (e) {
        values.add(0);
      }
    } else {
      values.add(0);
    }

    values2.add(DateTime.parse(
        "${controllers[0].text.substring(0, 8)}15${controllers[0].text.substring(10)}"));
    values2.add(DateTime.parse(
        "${controllers[1].text.substring(0, 8)}15${controllers[0].text.substring(10)}"));
    values2.add(values[0] * 0.024 / days);

    _sendData(values2, context);
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(numText, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  MyDateField(
                      controller: _controllers[0], valueText: "Start Date"),
                  const SizedBox(
                    height: 20,
                  ),
                  MyDateField(
                      controller: _controllers[1], valueText: "End Date"),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: _controllers[2],
                    hintText: "Electricity (in kWh)",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MyButton(
                      onTap: () => _saveData(_controllers, context),
                      strValue: "Save Data"),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
