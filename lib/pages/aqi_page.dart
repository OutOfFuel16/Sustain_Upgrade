import 'package:flutter/material.dart';

class AQIPage extends StatelessWidget {
  const AQIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Around Me'),
      ),
      body: const Center(
        child: Text(
          'This page will show AQI information.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
