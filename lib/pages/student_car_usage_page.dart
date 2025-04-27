import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentCarUsagePage extends StatefulWidget {
  @override
  _StudentCarUsagePageState createState() => _StudentCarUsagePageState();
}

class _StudentCarUsagePageState extends State<StudentCarUsagePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _rollCtrl = TextEditingController();
  final _fromCtrl = TextEditingController();
  final _toCtrl = TextEditingController();
  final _timeTakenCtrl = TextEditingController();
  String? _feasibility;

  void _reset() {
    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _rollCtrl.clear();
    _fromCtrl.clear();
    _toCtrl.clear();
    _timeTakenCtrl.clear();
    setState(() {
      _feasibility = null;
    });
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
      appBar: AppBar(title: Text("Student Car Usage")),
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
                controller: _rollCtrl,
                decoration: InputDecoration(labelText: "Roll Number"),
                validator: (v) => v!.isEmpty ? "Enter your roll number" : null,
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
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Feasibility of Bus/Bicycle/Walking",
                ),
                items: ["Yes", "No"]
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                value: _feasibility,
                onChanged: (v) => setState(() => _feasibility = v),
                validator: (v) => v == null ? "Please select an option" : null,
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
