import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ReportViolationPage extends StatefulWidget {
  @override
  _ReportViolationPageState createState() => _ReportViolationPageState();
}

class _ReportViolationPageState extends State<ReportViolationPage> {
  final _formKey = GlobalKey<FormState>();
  final _hostelCtrl = TextEditingController();
  final _floorCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime? _date;
  XFile? _image;

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

  Future<void> _pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _image = img);
  }

  void _reset() {
    _formKey.currentState?.reset();
    _hostelCtrl.clear();
    _floorCtrl.clear();
    _descCtrl.clear();
    setState(() {
      _date = null;
      _image = null;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for reporting the issue")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report Violation")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _hostelCtrl,
              decoration: InputDecoration(labelText: "Hostel Name"),
              validator: (v) => v!.isEmpty ? "Enter hostel name" : null,
            ),
            TextFormField(
              controller: _floorCtrl,
              decoration: InputDecoration(labelText: "Floor/Room Number"),
              validator: (v) => v!.isEmpty ? "Enter room/floor" : null,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date",
                hintText:
                    _date == null ? "Select date" : _date!.toLocal().toString().split(' ')[0],
              ),
              onTap: _pickDate,
              validator: (_) => _date == null ? "Choose a date" : null,
            ),
            TextFormField(
              controller: _descCtrl,
              decoration: InputDecoration(labelText: "Description"),
              maxLines: 4,
              validator: (v) => v!.isEmpty ? "Describe the violation" : null,
            ),
            SizedBox(height: 16),
            Row(children: [
              ElevatedButton(onPressed: _pickImage, child: Text("Upload Image")),
              SizedBox(width: 12),
              if (_image != null)
                Image.file(File(_image!.path), width: 80, height: 80, fit: BoxFit.cover),
            ]),
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
