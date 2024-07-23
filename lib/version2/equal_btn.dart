import 'calculate.dart';
import 'package:flutter/material.dart';
class EqualButton extends StatefulWidget {
  final Calculator calculator;

  EqualButton({super.key, required this.calculator});

  @override
  State<EqualButton> createState() => _EqualButtonState();
}

class _EqualButtonState extends State<EqualButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.calculator.equalPressed(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(70, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text("=", style: TextStyle(fontSize: 25),
      ),
    );
  }
}
