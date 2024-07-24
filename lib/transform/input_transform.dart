import 'package:calculater/transform/config.dart';
import 'package:calculater/widget/calculate.dart';

import 'package:flutter/material.dart';

class InputTransform extends StatefulWidget {

  final Calculator calculator;
  final Function(String) onCurrencySelected;

  const InputTransform({
    super.key,
    required this.calculator,
    required this.onCurrencySelected});

  @override
  State<InputTransform> createState() => _InputTransformState();
}

class _InputTransformState extends State<InputTransform> {
  String _selectedCurrency = '美元 USD';

  @override
  Widget build(BuildContext context) {
    // JumpToTransformListPage jumpToTransformListPage = JumpToTransformListPage();
    return Column(
      children: [

        ///跳转到ListPage
        // ListTile(
        //   //内边距
        //   contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        //   title: Text(_selectedCurrency),
        //   trailing: const Icon(Icons.chevron_right),
        //   onTap: () async {
        //     var currency= await jumpToTransformListPage.jumpToTransformListPage(context);
        //     setState(() {
        //       if (currency != null) {
        //         setState(() {
        //           _selectedCurrency = currency;
        //         });
        //         widget.onCurrencySelected(currency);
        //       }
        //     });
        //   },
        // ),

        /// 使用SimpleDialog弹出对话框
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          title: Text(_selectedCurrency),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            final selectedCurrency = await showDialog<String>(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: financeNames.map((currency) {
                    return SimpleDialogOption(
                      onPressed: () {
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
              widget.onCurrencySelected(selectedCurrency);
            }
            else{
              setState(() {
                _selectedCurrency = '美元 USD';
              });
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

        )
      ],
    );
  }
}

