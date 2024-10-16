import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class HomePageData extends StatelessWidget {
  final latestCarbonData;
  final double totalEmission;
  const HomePageData({super.key, required this.latestCarbonData, required this.totalEmission});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: height / 3,
                  width: width / 1.3,
                  child: PieChart(
                      PieChartData(sections: [
                        //Electricity
                        PieChartSectionData(
                          value: latestCarbonData[
                          'power']
                              .toDouble(),
                          //title: "Power",
                          radius: 25,
                          title: '',
                          color: Colors.orange[600]
                        ),
                        PieChartSectionData(
                          value: latestCarbonData[
                          'vehicle']
                              .toDouble(),
                          // title: "Vehicles",
                          radius: 25,
                          title: '',
                          color: Colors.cyan[200]
                        ),
                        PieChartSectionData(
                          value: latestCarbonData[
                          'publicTransport']
                              .toDouble(),
                          // title: "Movement",
                          radius: 25,
                          title: '',
                          color: Colors.blue[200]
                        ),
                        PieChartSectionData(
                          value: latestCarbonData[
                          'flight']
                              .toDouble(),
                          // title: "Flights",
                          radius: 25,
                          title: '',
                          color: Colors.pink[200]
                        ),
                        PieChartSectionData(
                          value:
                          latestCarbonData['food']
                              .toDouble(),
                          // title: "Food",
                          title: '',
                          radius: 25,
                          color: Colors.teal,
                        ),
                        PieChartSectionData(
                          value: latestCarbonData[
                          'secondary']
                              .toDouble(),
                          //title: "Secondary",
                          radius: 25,
                          title: '',
                          color: Colors.indigo[300]
                        ),
                      ])),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 8,
                    ),
                    SizedBox(
                      width: width / 2.5,
                      height: height / 14,
                      child: FittedBox(
                        child: Text(
                          (totalEmission).toStringAsPrecision(
                              5),
                          style: const TextStyle(
                            fontSize: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                        "Kgs of CO2 emission"),
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
          height: 30,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              DataCard(emission: totalEmission, labelText: "Power", field: "power", latestCarbonData: latestCarbonData,imagePath: 'lib/assets/images/electric.png',),
              const SizedBox(
                width: 20,
              ),
              DataCard(emission: totalEmission, labelText: "Vehicles ", field: "vehicle", latestCarbonData: latestCarbonData,imagePath: 'lib/assets/images/car.png'),
              const SizedBox(
                width: 20,
              ),
              DataCard(emission: totalEmission, labelText: "Travel", field: "publicTransport", latestCarbonData: latestCarbonData,imagePath: 'lib/assets/images/bus.png'),
              const SizedBox(
                width: 20,
              ),
              DataCard(emission: totalEmission, labelText: "Flights", field: "flight", latestCarbonData: latestCarbonData,imagePath: 'lib/assets/images/flight.png'),
              const SizedBox(
                width: 20,
              ),
              DataCard(emission: totalEmission, labelText: "Food", field: "food", latestCarbonData: latestCarbonData,imagePath: 'lib/assets/images/food.png'),
              const SizedBox(
                width: 20,
              ),
              DataCard(emission: totalEmission, labelText: "Others", field: "secondary", latestCarbonData: latestCarbonData,imagePath: 'lib/assets/images/money.png'),
              const SizedBox(
                width: 20,
              ),

            ],
          ),
        )
      ],
    );
  }
}



class DataCard extends StatelessWidget {
  final String field;
  final String labelText;
  final double emission;
  final latestCarbonData;
  final String? imagePath;

  const DataCard({super.key, required this.emission, required this.labelText, required this.field, required this.latestCarbonData, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      color: Colors.teal[800],

      child: Padding(
        padding:
        const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(labelText, style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 18),),
                if(imagePath!=null)Image.asset(imagePath!,height: 27,width: 27,)
              ],
            ),
            Text("${(latestCarbonData[field]/emission*100).toStringAsFixed(1)}%", style:  TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 16)),
            Text('${latestCarbonData[field].toStringAsFixed(3)} kgs', style:  TextStyle(color: Colors.grey[100],fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

