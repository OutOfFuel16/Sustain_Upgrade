import 'package:campus_carbon/decorators/button.dart';
import 'package:campus_carbon/decorators/text_field.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:campus_carbon/keys/urls.dart';


class AddDataPageOutlets extends StatefulWidget {
  const AddDataPageOutlets({super.key});

  @override
  State<AddDataPageOutlets> createState() => _AddDataPageOutletsState();
}

class _AddDataPageOutletsState extends State<AddDataPageOutlets> {
  List <String> locations = ["Tragopan / Tulsi",  "Pine Mess", "Oak Mess","Alder Mess", "Monal", "Drongo","One Bite", "Red Start", "MegaStar"];


  int numText = 20; //No. of text fields
  int numDropDowns = 4; //No. of Dropdowns

  late List<TextEditingController> _controllers;
  late List<int> _dropDowns;


  void _sendData(values, BuildContext context, String location) async{
    const String apiUrl = '${UrlConstants.apiUrl}/campus/save-data/outlets';

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
        'location': location,
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


  void _saveData(List<TextEditingController> controllers, List<int> choice, BuildContext context) {

    List<double> values = [];
    List values2 = [];
    List<DateTime> dates = [];

    dates.add(DateTime.parse(controllers[0].text));
    dates.add(DateTime.parse(controllers[1].text));

    Duration difference = dates[1].difference(dates[0]);
    // Calculate the number of days
    int days = difference.inDays + 1;

    for (int i = 0; i < controllers.length; i++) {
      String text = controllers[i].text.trim();

      if (text.isNotEmpty) {
        try {
          double value = double.parse(text);
          values.add(value);
        } catch (e) {
          //print("Error parsing value for controller $i: $e");
          values.add(0);
        }
      } else {
        values.add(0);
      }
    }


    values2.add(values[2] * 0.005/days);
    values2.add(values[3]*0.0064/days);
    values2.add(values[4]/85 * 2.7/days);
    values2.add(DateTime.parse("${controllers[0].text.substring(0,8)}15${controllers[0].text.substring(10)}"));
    values2.add(DateTime.parse("${controllers[1].text.substring(0,8)}15${controllers[0].text.substring(10)}"));
    values2.add(values[5]*0.0044/days);

    _sendData(values2,context, locations[choice[0]] );



  }



  @override
  void initState() {
    super.initState();
    _controllers = List.generate(numText, (index) => TextEditingController());
    _dropDowns = List.generate(numDropDowns, (index) => 0);
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

                  MyDropDown(
                      items: locations,
                      initialValue: _dropDowns[0],
                      onChanged: (int newValue) {
                        setState(() {
                          _dropDowns[0] = newValue;
                        });

                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyDateField(
                      controller: _controllers[0],
                      valueText: "Start Date"
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MyDateField(
                      controller: _controllers[1],
                      valueText: "End Date"
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  MyTextField(
                    controller: _controllers[2],
                    hintText: "Food (in Rupees)",
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  MyTextField(
                    controller: _controllers[3],
                    hintText: "Paper (in Rupees)",
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  MyTextField(
                    controller: _controllers[4],
                    hintText: "Gas (in Rupees)",
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  MyTextField(
                    controller: _controllers[5],
                    hintText: "Others (in Rupees)",
                  ),


                  const SizedBox(
                    height: 50,
                  ),


                  MyButton(
                      onTap: () => _saveData(_controllers, _dropDowns, context),
                      strValue: "Save Data"
                  ),


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
