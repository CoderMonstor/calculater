import 'package:flutter/material.dart';

import 'calculate.dart';

class ClearButton extends StatelessWidget {
  final Calculator calculator;

  const ClearButton({super.key, required this.calculator});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: calculator.clearButton,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(70, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        "CL",
        style: TextStyle(fontSize: 25,color: Colors.red),
      ),
    );
  }
}