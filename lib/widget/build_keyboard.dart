import '../animationDemo/shake.dart';
import 'calculate.dart';

import 'package:flutter/material.dart';

class buildKeyboard extends StatelessWidget {
  final Calculator calculator;
  const buildKeyboard({super.key, required this.calculator});

  @override
  Widget build(BuildContext context) {
    final List<List<String>> buttonRows = [
      ['(', ')', 'C', 'D'],
      ['1', '2', '3', '+'],
      ['4', '5', '6', '-'],
      ['7', '8', '9', '×'],
      ['0', '.', '=', '÷'],
    ];
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttonRows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((str) {
              return BuildButton(calculator: calculator, str: str);
            }).toList(),
          );
        }).toList(),
      )
    );
  }
}
