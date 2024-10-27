// lib/pages/electricity_page.dart
import 'package:flutter/material.dart';

class ElectricityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electricity'),
      ),
      body: Center(
        child: Text(
          'This is the Electricity page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
