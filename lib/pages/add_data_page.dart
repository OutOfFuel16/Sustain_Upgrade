import 'package:campus_carbon/decorators/button.dart';
import 'package:flutter/material.dart';
import 'package:campus_carbon/pages/add_data_page_outlets.dart';
import 'package:campus_carbon/pages/add_data_page_electricity.dart';


class AddDataPage extends StatelessWidget {
  const AddDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddDataPageOutlets())
                      );
                    },
                    strValue: "Outlets",startColor: Colors.blueGrey[700],
                  endColor: Colors.grey[900],imagePath: 'lib/assets/images/outlet.png',imageColor: Colors.white,),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddDataPageElectricity())
                      );
                    },
                    strValue: "Electricity",imagePath: 'lib/assets/images/bolt.png',imageColor: Colors.white,
                    endColor: Colors.blueGrey[700],
                    startColor: Colors.grey[900]),

                const SizedBox(
                  height: 100,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

