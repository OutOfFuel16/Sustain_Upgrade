// lib/pages/hostel_suggestions_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HostelSuggestionsPage extends StatefulWidget {
  const HostelSuggestionsPage({Key? key}) : super(key: key);

  @override
  _HostelSuggestionsPageState createState() => _HostelSuggestionsPageState();
}

class _HostelSuggestionsPageState extends State<HostelSuggestionsPage> {
  final _formKey = GlobalKey<FormState>();
  final _suggestionCtrl = TextEditingController();

  void _reset() {
    _formKey.currentState?.reset();
    _suggestionCtrl.clear();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thank you for your suggestion")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hostel Suggestions")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _suggestionCtrl,
                decoration: const InputDecoration(
                  labelText: "Your Suggestion",
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (v) => (v == null || v.isEmpty)
                    ? "Please enter a suggestion"
                    : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text("Submit"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Reset"),
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
