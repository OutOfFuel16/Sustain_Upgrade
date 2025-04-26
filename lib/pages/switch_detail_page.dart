import 'package:flutter/material.dart';

class SwitchDetailPage extends StatelessWidget {
  final String switchName;
  final String usageTime;

  const SwitchDetailPage(
      {super.key, required this.switchName, required this.usageTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(switchName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Usage Time: $usageTime',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
