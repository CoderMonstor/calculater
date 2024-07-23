import 'package:flutter/material.dart';

import 'calculate.dart';

class DeleteButton extends StatelessWidget {
  final Calculator calculator;

  const DeleteButton({super.key, required this.calculator});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:() async {
        calculator.onDeletePressed();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(70, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        "D",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}