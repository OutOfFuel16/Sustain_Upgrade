import 'package:flutter/material.dart';
import 'package:campus_carbon/decorators/text_field.dart';
import 'package:campus_carbon/decorators/button.dart';
import 'package:campus_carbon/pages/basic_output_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class TextStyle2 extends StatelessWidget {
  const TextStyle2({super.key, required this.fieldName, this.type = 0});
  final String fieldName;
  // 0 - normal 1 - sub heading 2 - heading
  final int type;
  static const List<List<dynamic>> specs = [
    [16.0, 0.5, FontWeight.w400],
    [25.0, 1.2, FontWeight.w600],
    [40.0, 10.0, FontWeight.w900]
  ];
  @override
  Widget build(BuildContext context) {
    if (type != 2) {
      return Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 15, right: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                fieldName,
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: specs[type][0],
                        color: Colors.grey[900],
                        letterSpacing: specs[type][1],
                        fontWeight: specs[type][2])),
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      fieldName,
      style: GoogleFonts.quicksand(
          textStyle: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.w900,
              fontSize: 40,
              letterSpacing: 10)),
    );
  }
}

class HeadingTextStyle extends StatelessWidget {
  final String text;
  const HeadingTextStyle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.mulish(
            textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w500)));
  }
}

class SmallTextStyle extends StatelessWidget {
  final String text;
  const SmallTextStyle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: GoogleFonts.quicksand(
                textStyle: const TextStyle(
                    fontSize: 27, fontWeight: FontWeight.w500))),
      ),
    );
  }
}

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({super.key});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  int numDropDowns = 20; //No. of Dropdowns

  late List<int> _dropDowns;

  late TabController _tabBarController;

  void next() {
    setState(() {
      _tabBarController.index = _tabBarController.index + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _dropDowns = List.generate(numDropDowns, (index) => 0);
    _tabBarController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      bottomNavigationBar: TabBar(
        controller: _tabBarController,
        tabAlignment: TabAlignment.fill,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        isScrollable: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabs: const [
          Tab(
            icon: Icon(Icons.electric_bolt),
            //text: 'Power',
          ),
          Tab(
            icon: Icon(Icons.emoji_transportation),
            //text: 'Vehicles',
          ),
          Tab(
            icon: Icon(Icons.train),
            //text: 'Travel',
          ),
          Tab(
            icon: Icon(Icons.shopping_bag),
            //text: 'Secondary',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabBarController,
        children: [
          ElectricScreen(
            choice: _dropDowns,
            next: next,
          ),
          TransportScreen(
            choice: _dropDowns,
            next: next,
          ),
          TravelScreen(
            choice: _dropDowns,
            next: next,
          ),
          SecondaryScreen(
            choice: _dropDowns,
            next: next,
          ),
        ],
      ),
    );
  }
}

class ElectricScreen extends StatefulWidget {
  final List<int> choice;
  final Function next;
  const ElectricScreen({super.key, required this.choice, required this.next});

  @override
  State<ElectricScreen> createState() => _ElectricScreenState();
}

class _ElectricScreenState extends State<ElectricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HeadingTextStyle(text: 'Electricity'),
                  Container(
                      child: Lottie.asset('lib/assets/electricity.json',
                          height: 100, width: 100)),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              //SmallTextStyle(text: 'Electricity Usage'),
              const TextStyle2(
                fieldName: 'Electricity Usage',
              ),
              MyDropDown(
                  items: const [
                    "A little (60 kwh / month) ",
                    "Average (150 kwh / month) ",
                    "Considerable (250 kwh / month) ",
                    "A lot (400 kwh / month) ",
                    "Extreme (750 kwh / month) ",
                  ],
                  initialValue: widget.choice[0],
                  onChanged: (int newValue) {
                    setState(() {
                      widget.choice[0] = newValue;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(
                  fieldName:
                      "Percentage of Electricity from Renewable Sources: "),
              MyDropDown(
                  items: const [
                    " 0 % ",
                    " 20 % ",
                    " 35 % ",
                    " 55 % ",
                    " 75 % ",
                    " 100 % ",
                  ],
                  initialValue: widget.choice[1],
                  onChanged: (int newValue) {
                    setState(() {
                      widget.choice[1] = newValue;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Natural Gas / LPG Usage: "),
              MyDropDown(
                  items: const [
                    "Minimal (< 2 kg / month)",
                    "A little (5 kg / month) ",
                    "Average (10 kg / month) ",
                    "Considerable (15 kg / month) ",
                    "A lot (25 kg / month) ",
                  ],
                  initialValue: widget.choice[2],
                  onChanged: (int newValue) {
                    setState(() {
                      widget.choice[2] = newValue;
                    });
                  }),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                onTap: () => widget.next(),
                strValue: "Next",
                imagePath: 'lib/assets/images/next.png',
                endColor: Colors.blueGrey[700],
                startColor: Colors.grey[900],
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  //imagePath: 'lib/assets/images/blowjob.png',
                  onTap: () => _calculate(widget.choice, context),
                  strValue: "Calculate",
                startColor:Colors.blueGrey[700] ,
                endColor: Colors.grey[900],
                // startColor: Color.fromRGBO(136, 129, 21  , 1),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransportScreen extends StatefulWidget {
  final List<int> choice;
  final Function next;
  const TransportScreen({super.key, required this.choice, required this.next});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const HeadingTextStyle(text: 'Vehicles'),

                Row(
                  children: [
                    const SmallTextStyle(text: "Car:"),
                    Lottie.asset('lib/assets/car.json', height: 150, width: 150)
                  ],
                ),

                const TextStyle2(fieldName: "Fuel Type: "),
                MyDropDown(
                    items: const ["Petrol ", "Diesel ", "CNG "],
                    initialValue: widget.choice[5],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[5] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Efficiency: "),
                MyDropDown(
                    items: const [
                      "Efficient (6 l / 100 km) ",
                      "Average (9 l / 100 km) ",
                      "Bad (12 l / 100 km) ",
                      "Extreme (18 l / 100 km) ",
                    ],
                    initialValue: widget.choice[6],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[6] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Mileage (Per Month) : "),
                MyDropDown(
                    items: const [
                      "Minimal (<10 km) ",
                      "A little (40 km) ",
                      "Average (120 km) ",
                      "Considerable (500 km) ",
                      "A lot (1200 km)",
                      "Extreme (3000 km)",
                    ],
                    initialValue: widget.choice[18],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[18] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SmallTextStyle(text: 'Bike: '),
                    Lottie.asset('lib/assets/bike.json',
                        height: 130, width: 150)
                  ],
                ),
                //TextStyle2(fieldName: 'Bike:',type: 1,),
                const TextStyle2(fieldName: "Fuel Type: "),
                MyDropDown(
                    items: const [
                      "Petrol ",
                      "Diesel ",
                    ],
                    initialValue: widget.choice[7],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[7] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Efficiency: "),
                MyDropDown(
                    items: const [
                      "Efficient (1 l / 100 km) ",
                      "Average (2 l / 100 km) ",
                      "Bad (3.5 l / 100 km) ",
                      "Extreme (6 l / 100 km) ",
                    ],
                    initialValue: widget.choice[8],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[8] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Mileage (Per Month): "),
                MyDropDown(
                    items: const [
                      "Minimal (<10 km) ",
                      "A little (40 km) ",
                      "Average (120 km) ",
                      "Considerable (500 km) ",
                      "A lot (1200 km)",
                      "Extreme (3000 km)",
                    ],
                    initialValue: widget.choice[19],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[19] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                  onTap: () => widget.next(),
                  strValue: "Next",
                  imagePath: 'lib/assets/images/next.png',
                  endColor: Colors.blueGrey[700],
                  startColor: Colors.grey[900],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    onTap: () => _calculate(widget.choice, context),
                    strValue: "Calculate",
                  startColor: Colors.blueGrey[700],
                  endColor: Colors.grey[900],
                ),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TravelScreen extends StatefulWidget {
  final List<int> choice;
  final Function next;
  const TravelScreen({super.key, required this.choice, required this.next});

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const HeadingTextStyle(text: 'Transport'),

                //const TextStyle2(fieldName: "Flights: ", type: 1,),
                Row(
                  children: [
                    const SmallTextStyle(text: 'Flights'),
                    const SizedBox(
                      width: 10,
                    ),
                    Lottie.asset('lib/assets/flight.json',
                        height: 110, width: 150)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Short Haul Flights (<1000km): "),
                MyDropDown(
                    items: const [
                      "None",
                      "2 one ways flights",
                      "4 one ways flights",
                      "8 one ways flights",
                      "24 one ways flights",
                    ],
                    initialValue: widget.choice[9],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[9] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Long Haul Flights (>=1000km): "),
                MyDropDown(
                    items: const [
                      "None",
                      "2 one ways flights",
                      "4 one ways flights",
                      "10 one ways flights",
                    ],
                    initialValue: widget.choice[10],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[10] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 40,
                ),
                //const TextStyle2(fieldName: "Public Transport: ", type: 1,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      const SmallTextStyle(text: 'Public Transport'),
                      Lottie.asset('lib/assets/bus.json',
                          height: 150, width: 120)
                    ],
                  ),
                ),
                const TextStyle2(fieldName: "Bus (Per Week): "),
                MyDropDown(
                    items: const ["< 10 km", "40 km", "80 km", "200 km"],
                    initialValue: widget.choice[11],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[11] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Metro (Per Week): "),
                MyDropDown(
                    items: const ["< 10 km", "40 km", "80 km", "200 km"],
                    initialValue: widget.choice[12],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[12] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Train (Per Year): "),
                MyDropDown(
                    items: const [
                      "None",
                      "400 km",
                      "1200 km",
                      "4000 km",
                    ],
                    initialValue: widget.choice[13],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[13] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                  onTap: () => widget.next(),
                  strValue: "Next",
                  imagePath: 'lib/assets/images/next.png',
                  endColor: Colors.blueGrey[700],
                  startColor: Colors.grey[900],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    onTap: () => _calculate(widget.choice, context),
                    strValue: "Calculate",
                  startColor: Colors.blueGrey[700],
                  endColor: Colors.grey[900],),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondaryScreen extends StatefulWidget {
  final List<int> choice;
  final Function next;
  const SecondaryScreen({super.key, required this.choice, required this.next});

  @override
  State<SecondaryScreen> createState() => _SecondaryScreenState();
}

class _SecondaryScreenState extends State<SecondaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const HeadingTextStyle(text: "Secondary"),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    const SmallTextStyle(text: 'Food'),
                    Lottie.asset('lib/assets/food.json',
                        height: 100, width: 150)
                  ],
                ),
                //SizedBox(height: -20,),
                const TextStyle2(fieldName: "Type: "),
                MyDropDown(
                    items: const [
                      "Vegan",
                      "Vegetarian",
                      "Meat Eater (5-6 servings/week)",
                      "Heavy Meat Eater(1-3 servings/day)"
                    ], // 2.8, 3.9, 7.2, 10.24
                    initialValue: widget.choice[14],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[14] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 50,
                ),

                Row(
                  children: [
                    const SmallTextStyle(text: 'Other Expenses'),
                    Lottie.asset('lib/assets/expense.json',
                        height: 150, width: 100)
                  ],
                ),
                const TextStyle2(fieldName: "Amount Spent on Textile & Shoe: "),
                MyDropDown(
                    items: const [
                      "A little (Rs. 1000 / month) ",
                      "Average (Rs. 2500 / month) ",
                      "A lot (Rs. 8000 / month) ",
                      "Extreme (Rs. 15000 / month) ",
                    ],
                    initialValue: widget.choice[15],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[15] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(
                    fieldName: "Amount Spent on Paper & Wood Products: "),
                MyDropDown(
                    items: const [
                      "A little (Rs. 1000 / month) ",
                      "Average (Rs. 2000 / month) ",
                      "A lot (Rs. 6000 / month) ",
                      "Extreme (Rs. 11000 / month) ",
                    ],
                    initialValue: widget.choice[16],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[16] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const TextStyle2(fieldName: "Amount Spent on Other Services: "),
                MyDropDown(
                    items: const [
                      "Minimal (Rs. 1000 / month) ",
                      "A little (Rs. 2500 / month) ",
                      "Considerable (Rs. 5000 / month) ",
                      "A lot (Rs. 15000 / month) ",
                      "Extreme (Rs. 30000 / month) "
                    ],
                    initialValue: widget.choice[17],
                    onChanged: (int newValue) {
                      setState(() {
                        widget.choice[17] = newValue;
                      });
                    }),
                const SizedBox(
                  height: 50,
                ),
                MyButton(
                    onTap: () => _calculate(widget.choice, context),
                    strValue: "Calculate",
                  startColor: Colors.blueGrey[700],
                  endColor: Colors.grey[900],),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _calculate(List<int> choice, BuildContext context) {
  const List<double> fuelToCarbon = [2.39, 2.64, 2.66];
  // 2.8, 3.9, 7.2, 10.24
  const List<double> foodToCarbon = [2.8, 3.9, 7.2, 10.24];

  const List<List<double>> refValues = [
    [60, 150, 250, 400, 750],
    [0, 0.2, 0.35, 0.55, 0.75, 1],
    [2, 5, 10, 15, 25],
    [],
    [],
    fuelToCarbon,
    [0.06, 0.09, 0.12, 0.18],
    fuelToCarbon,
    [0.01, 0.02, 0.035, 0.06],
    [0, 2, 4, 8, 24], //short flights
    [0, 2, 4, 10], //long flights
    [10, 40, 80, 200], //bus
    [10, 40, 80, 200], //metro
    [0, 400, 1200, 4000],
    foodToCarbon,
    [1000, 2500, 8000, 15000], //clothes
    [1000, 2000, 6000, 11000], //paper based
    [1000, 2000, 5000, 15000, 30000], //paper based
    [10, 40, 120, 500, 1200, 3000], //travel
    [10, 40, 120, 500, 1200, 3000], //travel
  ];

  List<double> values2 = [];

  double calculator(List<List<double>> refValues, List<int> choice) {
    double ans = 0;

    ans += refValues[0][choice[0]] *
        ((1 - refValues[1][choice[1]]) + refValues[1][choice[1]] / 20) *
        12 *
        0.71; //0.71 C02e/kwh

    ans += refValues[2][choice[2]] * 3 * 12;
    values2.add(ans);

    ans += refValues[5][choice[5]] *
        refValues[6][choice[6]] *
        refValues[18][choice[18]];
    ans += refValues[7][choice[7]] *
        refValues[8][choice[8]] *
        refValues[19][choice[19]];
    values2.add(ans - values2[0]);

    ans += refValues[9][choice[9]] * 800 * 0.2; // short flights
    ans += refValues[10][choice[10]] * 4000 * 0.121; //long flights

    values2.add(ans - values2[0] - values2[1]);

    ans += refValues[11][choice[11]] * 0.089 * 52; //bus
    ans += refValues[12][choice[12]] * 0.0324 * 52; //metro
    ans += refValues[13][choice[13]] * 0.033; //train // yearly

    values2.add(ans - values2[0] - values2[1] - values2[2]);

    ans += refValues[14][choice[14]] * 365; //food

    values2.add(ans - values2[0] - values2[1] - values2[2] - values2[3]);

    ans += refValues[15][choice[15]] * 12 * 0.00827; //clothes
    ans += refValues[16][choice[16]] * 12 * 0.0064; //paper
    ans += refValues[17][choice[17]] * 12 * 0.0034; //extra

    values2.add(
        ans - values2[0] - values2[1] - values2[2] - values2[3] - values2[4]);

    for (int i = 0; i < values2.length; i++) {
      values2[i] = values2[i] / 1000;
    }

    ans /= 1000;

    return ans;
  }

  double totalEmission = calculator(refValues, choice);

  _showOutput(totalEmission, context, values2);
}

void _showOutput(double totalEmissions, BuildContext context, List values) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              OutputPage(totalEmissions: totalEmissions, values: values)));
}
