
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:campus_carbon/decorators/button.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:campus_carbon/keys/urls.dart';


class CarbonData {
  final String id;
  final String email;
  final List<Map<String, dynamic>> carbonData;

  CarbonData({
    required this.id,
    required this.email,
    required this.carbonData,
  });

  factory CarbonData.fromJson(Map<String, dynamic> json) {
    return CarbonData(
      id: json['_id'],
      email: json['email'],
      carbonData: List<Map<String, dynamic>>.from(json['carbonData']),
    );
  }
}



class OutputPage extends StatelessWidget {
  final double totalEmissions;
  final List values;
  final String email;
  OutputPage(
      {super.key,
      required this.values,
      required this.totalEmissions,
      required this.email});

  void _save(List values, String email, double totalEmissions,
      BuildContext context) async {
    const String apiUrl = '${UrlConstants.apiUrl}/save-data';
    //const String apiUrl = 'http://192.168.139.109:3000/save-data';

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
        'email': email,
        'Value': data,
        'TotalEmissions': totalEmissions,
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
  final TextEditingController controller = TextEditingController();

  @override

  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      SafeArea(
                        child: Center(
                          child: SizedBox(
                            height: height/2 + height/8,
                            width: width/1.1,
                            child: PieChart(PieChartData(sections: [
                              //Electricity
                              PieChartSectionData(
                                value: values[10],
                                title: "Power",
                                color: const Color.fromARGB(255, 221, 87, 70),
                              ),
                              PieChartSectionData(
                                value: values[11],
                                title: "Vehicles",
                                color: const Color.fromARGB(255, 255, 196, 112),
                              ),
                              PieChartSectionData(
                                value: values[12],
                                title: "Movement",
                                color: const Color.fromARGB(255, 22, 121, 171),
                              ),
                              PieChartSectionData(
                                value: values[13],
                                title: "Flights",
                                color: const Color.fromARGB(255, 188, 127, 205),
                              ),
                              PieChartSectionData(
                                value: values[14],
                                title: "Food",
                                color: Colors.red,
                              ),
                              PieChartSectionData(
                                value: values[15],
                                title: "Secondary",
                                color: const Color.fromARGB(255, 19, 93, 102),
                              ),
                            ])),
                          ),
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height/4,
                            ),
                            SizedBox(
                              width: width/1.5,
                              height: height/9,
                              child: FittedBox(
                                child: Text(
                                  totalEmissions.toStringAsPrecision(5),
                                  style: const TextStyle(
                                    fontSize: 80,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text("Tons of CO2 emission"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Power and Electricity: "),
                      Text(values[10].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Vehicles: "),
                      Text(values[11].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Public Transportation: "),
                      Text(values[12].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Flights: "),
                      Text(values[13].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Food: "),
                      Text(values[14].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Secondary: "),
                      Text(values[15].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Start Date "),
                      Text("${values[6].day}/${values[6].month}/${values[6].year}"),
                    ],
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("End Date: "),
                      Text("${values[7].day}/${values[7].month}/${values[7].year}"),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                MyButton(
                    onTap: () {
                      _save(values, email, totalEmissions, context);
                    },
                    strValue: "Save"),

                const SizedBox(
                  height: 60,
                ),
                const Text("Your Carbon Footprint Yearly Estimation: ", style: TextStyle(fontSize: 15),),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: height / 3,

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: BarChart(BarChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        topTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return SideTitleWidget(axisSide: meta.axisSide, child: const Text("India"));
                                  case 1:
                                    return SideTitleWidget(axisSide: meta.axisSide, child: const Text("You"));
                                  case 2:
                                    return SideTitleWidget(axisSide: meta.axisSide, child: const Text("World"));
                                  default:
                                    return SideTitleWidget(axisSide: meta.axisSide, child: const Text(""));
                                }
                              },)
                        ),
                      ),
                      minY: 0,
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(
                              toY: 2.4,
                              width: 25,
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                          ),
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(
                              toY: totalEmissions/values[values.length - 1]*365,
                              width: 25,
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                              ),
                        ]),
                        BarChartGroupData(x: 2, barRods: [
                          BarChartRodData(
                              toY: 4.9,
                              width: 25,
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                              ),
                        ])
                      ],
                    )),
                  ),
                ),
                const SizedBox(
                  height: 100,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
