import 'config.dart';
import 'package:flutter/material.dart';

class OutputTransform extends StatelessWidget {
  final String result;
  final String? selectedCurrency;
  const OutputTransform({super.key, required this.result,this.selectedCurrency});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          title: Text('人民币 CNY'),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 30),),
        ),
      ],
    );
  }
}


