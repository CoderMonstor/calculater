import 'package:flutter/material.dart';


import 'calculate.dart';
import 'equal_btn.dart';
import 'clear_btn.dart';
import 'build_btn.dart';

class NumButtons extends StatefulWidget {

  final Calculator calculator;
  const NumButtons({super.key, required this.calculator});

  @override
  State<NumButtons> createState() => _NumButtonsState();
}

class _NumButtonsState extends State<NumButtons> {

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [
        Container(
          alignment: Alignment.bottomRight,
          height: 360,
          child: Text(
            widget.calculator.inputNum,
            style: const TextStyle(fontSize: 50),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: widget.calculator, str: '1'),
                BuildButton(calculator: widget.calculator, str: '2'),
                BuildButton(calculator: widget.calculator, str: '3'),
                BuildButton(calculator: widget.calculator, str: '+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: widget.calculator, str: '4'),
                BuildButton(calculator: widget.calculator, str: '5'),
                BuildButton(calculator: widget.calculator, str: '6'),
                BuildButton(calculator: widget.calculator, str: '-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: widget.calculator, str: '7'),
                BuildButton(calculator: widget.calculator, str: '8'),
                BuildButton(calculator: widget.calculator, str: '9'),
                BuildButton(calculator: widget.calculator, str: '×'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: widget.calculator, str: '0'),
                ClearButton(calculator: widget.calculator),
                EqualButton(calculator: widget.calculator),
                BuildButton(calculator: widget.calculator, str: '÷'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}




