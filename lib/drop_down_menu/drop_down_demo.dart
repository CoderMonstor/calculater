import 'package:calculater/transform/config.dart';
import 'package:flutter/material.dart';

class DropdownMenuDemo extends StatefulWidget {
  final Function(String)? onChanged; // 回调函数

  const DropdownMenuDemo({super.key, this.onChanged});

  @override
  State<DropdownMenuDemo> createState() => _DropdownMenuDemoState();
}

class _DropdownMenuDemoState extends State<DropdownMenuDemo> {
  late String _dropdownValue = financeNames.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _dropdownValue,
      items: _buildMenuList(financeNames),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownValue = newValue!;
        });
        widget.onChanged?.call(newValue!);
      },
    );
  }

  List<DropdownMenuItem<String>> _buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}