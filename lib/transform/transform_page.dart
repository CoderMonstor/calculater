import 'config.dart';
import 'input_transform.dart';
import 'output_transform.dart';
import 'package:calculater/widget/calculate.dart';
import 'package:calculater/widget/build_keyboard.dart';

import 'package:flutter/material.dart';

class TransformPage extends StatefulWidget {
  const TransformPage({super.key});

  @override
  _TransformPageState createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage> {
  String _selectedCurrency = '美元 USD';
  String _result = '';
  Calculator calculator = Calculator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                InputTransform(
                    onCurrencySelected: _onCurrencySelected,
                    calculator: calculator),
                OutputTransform(result: _result),
              ],
            ),
          ),
          buildKeyboard(calculator: calculator),
        ],
      ),
    );
  }

  void _convert() {
    final amount = double.tryParse(calculator.inputNum);
    if (amount != null) {
      final converter = CurrencyConverter();
      final result = converter.convertToCNY(_selectedCurrency, amount);
      setState(() {
        _result = '$result';
      });
    } else {
      setState(() {
        _result = '';
      });
    }
  }

  void _onCurrencySelected(String currency) {
    setState(() {
      _selectedCurrency = currency;
      _convert(); // 如果需要，更新选择货币后立即转换
    });
  }
}
