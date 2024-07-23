import 'package:calculater/transform/config.dart';
import 'package:calculater/transform/input_transform.dart';
import 'package:calculater/transform/output_transform.dart';
import 'package:calculater/widget/calculate.dart';
import 'package:calculater/widget/build_num_btn.dart';

import 'keyboard.dart';
import 'package:flutter/material.dart';

class TransformPage extends StatefulWidget {
  const TransformPage({super.key});

  @override
  State<TransformPage> createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TransformKeyboardPage(),
    );
  }
}


class TransformKeyboardPage extends StatefulWidget {
  const TransformKeyboardPage({super.key});

  @override
  _TransformKeyboardPageState createState() => _TransformKeyboardPageState();
}

class _TransformKeyboardPageState extends State<TransformKeyboardPage> {

  /// 用于监听和控制文本输入框中的文本变化。
  final TextEditingController _controller = TextEditingController();
  String _selectedCurrency = '美元 USD';
  String _result = '';
  Calculator calculator=Calculator();

  void _onKeyTap(String value) {
    setState(() {
      _controller.text += value;
    });
    _convert();
  }

  void _convert() {
    /// 将文本字段的内容解析为双精度浮点数。
    /// 获取用户输入的金额值
    final amount = double.tryParse(_controller.text);
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
      _convert(); // 更新选择货币后立即转换
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InputTransform(
            controller: _controller,
            onCurrencySelected: _onCurrencySelected,
          ),
          OutputTransform(result: _result),
          // SizedBox(
          //   width: 150,
          //   height: 150,
          //   child: ElevatedButton(
          //     onPressed: (){
          //       showDialog(
          //           context: context,
          //           builder: (context){
          //             return SimpleDialog(
          //               children: [
          //                 const Center(child: Text('计算结果',style: TextStyle(fontSize: 20),)),
          //                 Center(child: Text(_result,style: const TextStyle(fontSize: 20),)),
          //               ],
          //             );
          //           });
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.blue[100],
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //     child:const Center(child: Text('计算',style: TextStyle(fontSize: 50),)),
          //   ),
          // ),
          buildKeyboard(calculator: calculator),
          // SizedBox(
          //   height: 265.0, // 设置具体高度
          //   child: buildCustomKeyboard(
          //     onKeyTap: _onKeyTap,
          //     selectedCurrency: _selectedCurrency,
          //     onConvert: _convert,
          //   ),
          // ),
        ],
      ),
    );
  }


}

