import 'package:flutter/material.dart';
import 'package:generic_picker_scroll/generic_picker_scroll.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _value = 175.0;
  String _unit = 'cm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generic Value Picker Example"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              "$_value $_unit",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 250,
            child: GenericValuePicker(
              value: _value,
              unit: _unit,
              minValue: 100,
              maxValue: 250,
              units: const ['cm', 'm', 'in', 'ft'],
              onValueChanged: (double value, String unit) {
                setState(() {
                  _value = value;
                  _unit = unit;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
