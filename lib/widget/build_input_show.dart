import 'package:calculater/history/history.dart';
import 'package:flutter/cupertino.dart';

import 'calculate.dart';
import 'package:flutter/material.dart';

class InputShow extends StatefulWidget {

  final Calculator calculator;
  const InputShow({super.key,required this.calculator});

  @override
  State<InputShow> createState() => _InputShowState();
}

class _InputShowState extends State<InputShow> {
  final double _fontSize = 50;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 1,
      child:Column(
        children: [
          const SingleChildScrollView(
            child:
              SizedBox(
                  width: 400,
                  height: 150,
                  child: History()),
          ),
          Container(
            alignment: Alignment.bottomRight,
            // color: Colors.blue[100],
            child: Text(
              widget.calculator.inputNum+widget.calculator.result,
              style: TextStyle(fontSize: _fontSize),
            ),
          )
        ],
      ),
    );
  }
}


