import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}

class MyDropDown extends StatefulWidget {
  final List<String> items;
  final int initialValue;
  final Function(int) onChanged;

  const MyDropDown({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
        value: _selectedValue,
        onChanged: (int? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedValue = newValue;
              widget.onChanged(newValue);
            });
          }
        },
        //style: TextStyle(color: Colors.black),
        //dropdownColor: Colors.grey.shade200,
        // icon: Icon(Icons.arrow_drop_down),
        // iconSize: 36.0,
        //isExpanded: true,

        dropdownColor: Colors.grey[300],

        items: widget.items
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                DropdownMenuItem<int>(
                  value: index,
                  child: Center(child: Text(value, style: TextStyle(color: Colors.grey[700]),)),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}

class MyDateField extends StatefulWidget {
  final TextEditingController controller;
  final String valueText;

  const MyDateField({
    super.key,
    required this.controller,
    required this.valueText,
  });

  @override
  State<MyDateField> createState() => _MyDateFieldState();
}

class _MyDateFieldState extends State<MyDateField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onTap: () => _selectDate(),
        readOnly: true,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: widget.valueText,
            labelStyle: TextStyle(
                color: Colors.grey[700],
                fontSize: 18
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));

    if (picked != null) {
      setState(() {
        widget.controller.text = picked.toString().split(" ")[0];
      });
    }
  }
}
