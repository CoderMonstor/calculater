import 'package:calculater/transform/config.dart';
import 'package:calculater/widget/calculate.dart';

import 'package:flutter/material.dart';

class InputTransform extends StatefulWidget {

  final Calculator calculator;
  final Function(String) onCurrencySelected;

  const InputTransform({
    super.key,
    required this.calculator,
    required this.onCurrencySelected,});

  @override
  State<InputTransform> createState() => _InputTransformState();
}

class _InputTransformState extends State<InputTransform> {
  String _selectedCurrency = '美元 USD';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 使用SimpleDialog弹出对话框
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          title: Text(_selectedCurrency),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            /// 显示一个对话框，让用户从给定的货币列表中选择一种货币
            /// 返回用户选择的货币名称
            final selectedCurrency = await showDialog<String>(
              context: context,
              builder: (context) {
                /// 构建一个SimpleDialog用于展示货币选项
                return SimpleDialog(
                  children: financeNames.map((currency) {
                    /// 为每个货币选项构建一个SimpleDialogOption
                    return SimpleDialogOption(
                      onPressed: () {
                        /// 当选项被选中时，通过Navigator.pop返回选中的货币名称
                        Navigator.pop(context, currency);
                      },
                      child: Text(currency),
                    );
                  }).toList(),
                );
              },
            );
            if (selectedCurrency != null) {
              setState(() {
                _selectedCurrency = selectedCurrency;
              });
              widget.onCurrencySelected(_selectedCurrency);
            }
            else{
              widget.onCurrencySelected(_selectedCurrency);
            }
          },
        ),
          Container(
            padding:const EdgeInsets.only(right: 50) ,
            alignment: Alignment.bottomRight,
            child: Text(
              widget.calculator.inputNum,
              style: const TextStyle(fontSize: 30),),
          ),
      ],
    );
  }
}

