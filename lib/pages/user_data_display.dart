import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:campus_carbon/keys/urls.dart';
import 'package:lottie/lottie.dart';

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

class UserData extends StatefulWidget {
  final String email;
  const UserData({super.key, required this.email});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  bool dataPage = false;
  String jsonData = '';



  void togglePages() {
    setState(() {
      dataPage = !dataPage;
    });
  }

  void _getData(String email, BuildContext context) async {
    String apiUrl = '${UrlConstants.apiUrl}/get-data?email=$email';

    //String apiUrl = 'http://192.168.139.109:3000/get-data?email=$email';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      //_showResultDialog("Data sent successfully ${response.body}", context);
      togglePages();
      setState(() {
        jsonData = response.body;
      });
    } else {
      _showResultDialog(
          "Failed to retrieve data. Error: ${response.statusCode}", context);
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

  @override
  Widget build(BuildContext context) {
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    if (!dataPage) {
      _getData(widget.email, context);
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child:
              Lottie.asset('lib/assets/twodots.json', width: 200, height: 200),
        ),
      );
    } else {
      final Map<String, dynamic> parsedJson = jsonDecode(jsonData);
      final carbonData = CarbonData.fromJson(parsedJson['data']);
      final latestCarbonData = findLatest(carbonData);
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.grey[300],
          title: Row(
            children: [
              Text('Carbon Data',style: GoogleFonts.mulish(textStyle:const TextStyle()),),
              Lottie.asset('lib/assets/data.json',width: 120,height: 100)
            ],
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: carbonData.carbonData.length,
            itemBuilder: (context, index) {
              carbonData.carbonData[index]["endDate"] =
                  carbonData.carbonData[index]["endDate"].toString();
              carbonData.carbonData[index]["startDate"] =
                  carbonData.carbonData[index]["startDate"].toString();
              final values = carbonData.carbonData[index];
              return ListTile(
                subtitle: Card(
                  color: Colors.grey[300],
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 12, vertical: 20),
                        child: Center(
                          child: Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Month: ",
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                  Text(
                                    //"${values["startDate"].day}/${values["startDate"].month}/${values["startDate"].year}",
                                    "${months[int.parse(values["startDate"].substring(5,7)) - 1]}, ${values["startDate"].substring(0,4)}",
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Card(
                        //       color: Colors.black,
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        //         child: Column(
                        //           children: [
                        //             Text(
                        //               "Start Date: ",
                        //               style: TextStyle(
                        //                 color: Colors.grey[100],
                        //               ),
                        //             ),
                        //             Text(
                        //               //"${values["startDate"].day}/${values["startDate"].month}/${values["startDate"].year}",
                        //               "${values["startDate"].substring(0,10)}",
                        //               style: TextStyle(
                        //                 color: Colors.grey[100],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     Card(
                        //       color: Colors.black,
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        //         child: Column(
                        //           children: [
                        //             Text(
                        //               "End Date: ",
                        //               style: TextStyle(
                        //                 color: Colors.grey[100],
                        //               ),
                        //             ),
                        //             Text(
                        //                 style: TextStyle(
                        //                   color: Colors.grey[100],
                        //                 ),
                        //                 //"${values["endDate"].day}/${values["endDate"].month}/${values["endDate"].year}"
                        //               "${values["endDate"].substring(0,10)}"
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Due to Power and Electricity: "),
                            Text(values["power"].toStringAsPrecision(5)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Due to Vehicles: "),
                            Text(values["vehicle"].toStringAsPrecision(5)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Due to Public Transportation: "),
                            Text(values["publicTransport"]
                                .toStringAsPrecision(5)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Due to Flights: "),
                            Text(values["flight"].toStringAsPrecision(5)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Due to Food: "),
                            Text(values["food"].toStringAsPrecision(5)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Due to Secondary: "),
                            Text(values["secondary"].toStringAsPrecision(5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // ],
          // ),
        ),
      );
    }
  }
}

findLatest(CarbonData carbonData) {
  var j = carbonData.carbonData[0];
  for (var i in carbonData.carbonData) {
    if (DateTime.parse(j['startDate'])
        .isBefore(DateTime.parse(i['startDate']))) {
      j = i;
    }
  }

  for (var k in [
    'power',
    'vehicle',
    'publicTransport',
    'flight',
    'food',
    'secondary'
  ]) {
    j[k] *= 30 * 1000;
  }
  return j;
}
