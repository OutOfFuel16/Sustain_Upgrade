import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailySupplyFormPage extends StatefulWidget {
  const DailySupplyFormPage({Key? key}) : super(key: key);

  @override
  State<DailySupplyFormPage> createState() => _DailySupplyFormPageState();
}

class _DailySupplyFormPageState extends State<DailySupplyFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _date;
  final _supplyToCtrl = TextEditingController();
  final _supplyAmountCtrl = TextEditingController();
  String? _supplySource;

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
    _supplyToCtrl.clear();
    _supplyAmountCtrl.clear();
    setState(() {
      _supplySource = null;
      _date = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daily Supply Analysis')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date",
                  hintText: _date == null
                      ? "Select date"
                      : _date!.toLocal().toString().split(' ')[0],
                ),
                onTap: _pickDate,
                validator: (_) => _date == null ? "Select a date" : null,
              ),
              TextFormField(
                controller: _supplyToCtrl,
                decoration: InputDecoration(labelText: "Supply To"),
                validator: (v) => v!.isEmpty ? "Enter where supply is made" : null,
              ),
              TextFormField(
                controller: _supplyAmountCtrl,
                decoration: InputDecoration(labelText: "Supply Amount (in litres)"),
                validator: (v) => v!.isEmpty ? "Enter supply amount" : null,
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Supply Source"),
                items: ["Main Pipeline", "Tanker", "Side Pipeline", "Others"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: _supplySource,
                onChanged: (v) => setState(() => _supplySource = v),
                validator: (v) => v == null ? "Select supply source" : null,
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
