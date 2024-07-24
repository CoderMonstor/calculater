import 'package:calculater/history/history.dart';
import 'package:flutter/cupertino.dart';

import 'calculate.dart';
import 'package:flutter/material.dart';

class InputShow extends StatefulWidget {

  Calculator calculator;
  InputShow({super.key,required this.calculator});

  @override
  State<InputShow> createState() => _InputShowState();
}

class _InputShowState extends State<InputShow> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 1,
      child:Column(
        children: [
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
            // SizedBox(
            //     width: 400,
            //     height: 150,
            //     child: History())
              SizedBox(
                  width: 400,
                  height: 150,
                  child: History()),
          ),
          Container(
            alignment: Alignment.bottomRight,
            // color: Colors.blue[100],
            child: Text(
              widget.calculator.inputNum,
              style: const TextStyle(fontSize: 50),
            ),
          )
        ],
      ),
    );
  }
}


