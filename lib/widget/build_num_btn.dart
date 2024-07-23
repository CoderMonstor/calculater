import 'equal_btn.dart';
import '../animationDemo/btn_shake_animation.dart';
import 'calculate.dart';
import 'clear_btn.dart';
import 'delete_btn.dart';
import 'package:flutter/material.dart';

class buildKeyboard extends StatelessWidget {
  final Calculator calculator;
  const buildKeyboard({super.key, required this.calculator});


  @override
  Widget build(BuildContext context) {
      return Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildButton(calculator: calculator, str: '('),
                BuildButton(calculator: calculator, str: ')'),
                ClearButton(calculator: calculator),
                DeleteButton(calculator: calculator)
              ],
            ),
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
                BuildButton(calculator: calculator, str: '.'),
                EqualButton(calculator: calculator),
                BuildButton(calculator: calculator, str: '÷'),
              ],
            ),
          ],
        ),
      );
  }
}
