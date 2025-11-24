import 'package:flutter/material.dart';
import 'package:generic_picker_scroll/generic_picker_scroll.dart';

void main() {
  runApp(const MaterialApp(home: ValuePickerExample()));
}

class ValuePickerExample extends StatefulWidget {
  const ValuePickerExample({Key? key}) : super(key: key);

  @override
  State<ValuePickerExample> createState() => _ValuePickerExampleState();
}

class _ValuePickerExampleState extends State<ValuePickerExample> {
  double _height = 175.0;
  String _heightUnit = 'cm';
  
  double _weight = 70.0;
  String _weightUnit = 'kg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generic Value Picker Example"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Height picker
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Height",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              "$_height $_heightUnit",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 250,
            child: GenericValuePicker(
              value: _height,
              unit: _heightUnit,
              minValue: 100,
              maxValue: 250,
              units: const ['cm', 'm', 'in', 'ft'],
              onValueChanged: (double value, String unit) {
                setState(() {
                  _height = value;
                  _heightUnit = unit;
                });
              },
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Weight picker
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Weight",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              "$_weight $_weightUnit",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 250,
            child: GenericValuePicker(
              value: _weight,
              unit: _weightUnit,
              minValue: 30,
              maxValue: 200,
              units: const ['kg', 'g', 'lb', 'oz'],
              onValueChanged: (double value, String unit) {
                setState(() {
                  _weight = value;
                  _weightUnit = unit;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

