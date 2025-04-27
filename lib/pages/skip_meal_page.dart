import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkipMealPage extends StatefulWidget {
  @override
  _SkipMealPageState createState() => _SkipMealPageState();
}

class _SkipMealPageState extends State<SkipMealPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _rollCtrl = TextEditingController();
  String? _meal;
  DateTime? _date;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(Duration(days: 365)),
      lastDate: now.add(Duration(days: 365)),
    );
    if (d != null) setState(() => _date = d);
  }

  void _reset() {
    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _rollCtrl.clear();
    setState(() {
      _meal = null;
      _date = null;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for your valuable feedback")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skip Meal")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Select Meal"),
              items: ["Breakfast", "Lunch", "Dinner"]
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              value: _meal,
              onChanged: (v) => setState(() => _meal = v),
              validator: (v) => v == null ? "Please choose a meal" : null,
            ),
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
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date",
                hintText:
                    _date == null ? "Select date" : _date!.toLocal().toString().split(' ')[0],
              ),
              onTap: _pickDate,
              validator: (_) => _date == null ? "Select a date" : null,
            ),
            SizedBox(height: 24),
            Row(children: [
              Expanded(child: ElevatedButton(onPressed: _submit, child: Text("Submit"))),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _reset,
                  child: Text("Reset"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
