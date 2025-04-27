import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessSuggestionsPage extends StatefulWidget {
  @override
  _MessSuggestionsPageState createState() => _MessSuggestionsPageState();
}

class _MessSuggestionsPageState extends State<MessSuggestionsPage> {
  final _formKey = GlobalKey<FormState>();
  final _ctrl = TextEditingController();

  void _reset() => setState(() {
        _formKey.currentState?.reset();
        _ctrl.clear();
      });

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for your suggestion")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mess Suggestions")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _ctrl,
              decoration: InputDecoration(labelText: "Your Suggestion"),
              maxLines: 5,
              validator: (v) => v!.isEmpty ? "Enter something" : null,
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
