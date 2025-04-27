import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceAnalysisFormPage extends StatefulWidget {
  const MaintenanceAnalysisFormPage({Key? key}) : super(key: key);

  @override
  State<MaintenanceAnalysisFormPage> createState() => _MaintenanceAnalysisFormPageState();
}

class _MaintenanceAnalysisFormPageState extends State<MaintenanceAnalysisFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _monthCtrl = TextEditingController();
  final _costCtrl = TextEditingController();
  final _commentsCtrl = TextEditingController();
  String? _maintenanceType;

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data Submitted')),
      );
      Navigator.pop(context);
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _monthCtrl.clear();
    _costCtrl.clear();
    _commentsCtrl.clear();
    setState(() {
      _maintenanceType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Maintenance Analysis')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _monthCtrl,
                decoration: InputDecoration(labelText: "Month"),
                validator: (v) => v!.isEmpty ? "Enter month" : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Maintenance Type"),
                items: [
                  "Electricity Bill",
                  "Chemicals",
                  "Leakage Fix",
                  "Check",
                  "Others",
                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                value: _maintenanceType,
                onChanged: (v) => setState(() => _maintenanceType = v),
                validator: (v) => v == null ? "Select maintenance type" : null,
              ),
              TextFormField(
                controller: _costCtrl,
                decoration: InputDecoration(labelText: "Maintenance Cost"),
                validator: (v) => v!.isEmpty ? "Enter cost" : null,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _commentsCtrl,
                decoration: InputDecoration(labelText: "Comments"),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: _submit, child: Text("Submit")),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      child: Text("Reset"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
