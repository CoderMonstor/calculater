import 'package:calculater/transform/config.dart';
import 'package:calculater/transform/keyboard.dart';

import 'drop_down_demo.dart';
import 'package:flutter/material.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({super.key});

  @override
  State<DropDownPage> createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  final _titleText1 = TextEditingController();
  final _titleText2 = TextEditingController();
  String? _selectedValue;
  String? _selectedValue2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                      "0"
              ),
            ),
            DropdownMenuDemo(
              onChanged: (value) {
                setState(() {
                  _selectedValue = value; // 更新第一个下拉菜单的选择值
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _titleText2,
                decoration: const InputDecoration(
                  hintText: '请输入',
                ),
              ),
            ),
            DropdownMenuDemo(
              onChanged: (value) {
                setState(() {
                  _selectedValue2 = value; // 更新第二个下拉菜单的选择值
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // 获取两个 TextField 的值
                String text1 = _titleText1.text;
                String text2 = _titleText2.text;

                // 计算汇率
                double? rate1 = exchangeRatesToCNY[_selectedValue];
                double? rate2 = exchangeRatesToCNY[_selectedValue2];
                double? exchangeRate;

                if (rate1 != null && rate2 != null) {
                  exchangeRate = rate1 / rate2;
                }

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Icon(Icons.add_photo_alternate_outlined),
                      content: Text(
                        "$_selectedValue 转 $_selectedValue2 汇率: ${exchangeRate?.toStringAsFixed(4) ?? '无效的汇率'}",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("确定"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("转换"),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: buildCustomKeyboard(),
        )
      ],
    );
  }
}