import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'calculate.dart';
import 'equal_btn.dart';
import 'clear_btn.dart';
import 'build_btn_shake.dart';

class NumButtons extends StatefulWidget {

  const NumButtons({super.key});

  @override
  State<NumButtons> createState() => _NumButtonsState();
}

class _NumButtonsState extends State<NumButtons> {

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomRight,
          height: 360,
          child: Text(
            calculator.inputNum,
            style: const TextStyle(fontSize: 50),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: calculator, str: '1'),
                BuildButton(calculator: calculator, str: '2'),
                BuildButton(calculator: calculator, str: '3'),
                BuildButton(calculator: calculator, str: '+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: calculator, str: '4'),
                BuildButton(calculator: calculator, str: '5'),
                BuildButton(calculator: calculator, str: '6'),
                BuildButton(calculator: calculator, str: '-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: calculator, str: '7'),
                BuildButton(calculator: calculator, str: '8'),
                BuildButton(calculator: calculator, str: '9'),
                BuildButton(calculator: calculator, str: '×'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: calculator, str: '0'),
                ClearButton(calculator: calculator),
                EqualButton(calculator: calculator),
                BuildButton(calculator: calculator, str: '÷'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}




