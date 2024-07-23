import 'calculate.dart';
import 'package:flutter/material.dart';

class InputShow extends StatelessWidget {
  Calculator calculator;
  InputShow({super.key,required this.calculator});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child:Container(
        alignment: Alignment.bottomRight,
        height: 300,
        child: Text(
          calculator.inputNum,
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
