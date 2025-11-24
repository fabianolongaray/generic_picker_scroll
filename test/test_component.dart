import 'package:flutter/material.dart';
import 'package:generic_picker_scroll/generic_picker_scroll.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _value = 70.0;
  String _unit = 'kg';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final unselectedStyle = (textTheme.headlineSmall ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
        .copyWith(color: const Color(0xFFB7B9BB));
    final selectedStyle = (textTheme.headlineMedium ??
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        .copyWith(color: const Color(0xFF0F161E));

    final scrollViewOptions = GenericValueScrollViewOptions(
      alignment: Alignment.center,
      textStyle: unselectedStyle,
      selectedTextStyle: selectedStyle,
      horizontalPadding: 16,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Generic Value Picker Test"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              "$_value $_unit",
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 250,
            child: GenericValuePicker(
              value: _value,
              unit: _unit,
              minValue: 30,
              maxValue: 200,
              units: const ['kg', 'g', 'lb', 'oz'],
              options: const GenericValuePickerOptions(
                backgroundColor: Color(0xFFFAFAFB),
                indicatorColor: Color(0xFFFFFFFF),
                indicatorBorderRadius: BorderRadius.all(Radius.circular(8)),
                isLoop: false,
              ),
              integerOptions: scrollViewOptions.copyWith(
                horizontalPadding: 16,
              ),
              decimalOptions: scrollViewOptions.copyWith(
                horizontalPadding: 16,
              ),
              unitOptions: scrollViewOptions.copyWith(
                horizontalPadding: 20,
                alwaysUseUnselectedStyle: true,
              ),
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