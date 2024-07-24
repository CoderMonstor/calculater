import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'calculate.dart';
import 'build_keyboard.dart';
import 'build_input_show.dart';
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
        InputShow(calculator: calculator),
        buildKeyboard(calculator: calculator),
      ],
    );
  }
}



