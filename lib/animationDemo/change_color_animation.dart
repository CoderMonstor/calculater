import 'package:flutter/material.dart';
import '../widget/calculate.dart';
class BuildButton extends StatefulWidget {
  final String str;
  final Calculator calculator;

  const BuildButton({super.key, required this.calculator, required this.str});

  @override
  _BuildButtonState createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.calculator.onButtonPressed(widget.str);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: _isPressed ? Colors.blue : const Color.fromARGB(20, 47,242,250), // 按下时改变颜色
          // border: Border.all(color: Colors.grey, width: 2,),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            widget.str,
            style: const TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      ),
    );
  }

}

