import 'package:flutter/material.dart';


class buildCustomKeyboard extends StatefulWidget {

  final Function(String)? onKeyTap;
  final Function? onConvert;
  final Function? updateInput;
  final String? selectedCurrency;

  const buildCustomKeyboard({
    super.key,
    this.onKeyTap,
    this.selectedCurrency,
    this.onConvert,
    this.updateInput,
  });

  @override
  State<buildCustomKeyboard> createState() => _buildCustomKeyboardState();
}

class _buildCustomKeyboardState extends State<buildCustomKeyboard> {

  String result = '';

  @override
  Widget build(BuildContext context) {
    return _buildCustomKeyboard();
  }

  Widget _buildCustomKeyboard() {
    return Container(
      color: Colors.grey[200],
      child: GridView.count(
        crossAxisCount: 3,
        /// 这个比例用于确定GridView中每个子元素的宽度和高度之间的关系
        childAspectRatio: 2,
        children: [
          _buildKey('1'),
          _buildKey('2'),
          _buildKey('3'),
          _buildKey('4'),
          _buildKey('5'),
          _buildKey('6'),
          _buildKey('7'),
          _buildKey('8'),
          _buildKey('9'),
          _buildKey('0'),
          _buildKey('D'), // 删除键
          _buildKey('C'), // 清空键
        ],
      ),
    );
  }

  Widget _buildKey(String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (value == 'D') {
            if (result.isNotEmpty) {
              result = result.substring(0,result.length - 1);
            }
          } else if (value == 'C') {
            result='';
          } else {
            result += value;
            // widget.onKeyTap!(value);
          }
        });

      },

      child: Container(
        //边距5
        margin: const EdgeInsets.all(5.0),
        color: Colors.white,
        child: Center(
          child: Text(
            value,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
