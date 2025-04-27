import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FacultyCarUsagePage extends StatefulWidget {
  @override
  _FacultyCarUsagePageState createState() => _FacultyCarUsagePageState();
}

class _FacultyCarUsagePageState extends State<FacultyCarUsagePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _fromCtrl = TextEditingController();
  final _toCtrl = TextEditingController();
  final _timeTakenCtrl = TextEditingController();

  void _reset() {
    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _fromCtrl.clear();
    _toCtrl.clear();
    _timeTakenCtrl.clear();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for your input!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Faculty Car Usage")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(labelText: "Name"),
                validator: (v) => v!.isEmpty ? "Enter your name" : null,
              ),
              TextFormField(
                controller: _fromCtrl,
                decoration: InputDecoration(labelText: "From"),
                validator: (v) => v!.isEmpty ? "Enter starting location" : null,
              ),
              TextFormField(
                controller: _toCtrl,
                decoration: InputDecoration(labelText: "To"),
                validator: (v) => v!.isEmpty ? "Enter destination" : null,
              ),
              TextFormField(
                controller: _timeTakenCtrl,
                decoration: InputDecoration(labelText: "Time Taken (in mins)"),
                validator: (v) => v!.isEmpty ? "Enter time taken" : null,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: Text("Submit"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      child: Text("Reset"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
