import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class Calculator extends ChangeNotifier {
  String inputNum = '';
  String result = '';

  void onButtonPressed(String value) {
    // 如果第一个输入的是操作符，则不进行任何操作
    if (inputNum.isEmpty && isOperator(value)&& inputNum[0] == ')') {
      return;
    }
    // 如果当前输入的是操作符，并且前一个字符也是操作符，则替换掉前一个操作符
    if (isOperator(value) && inputNum.isNotEmpty && isOperator(inputNum[inputNum.length - 1]) && inputNum[inputNum.length - 1] != '(') {
      inputNum = inputNum.substring(0, inputNum.length - 1) + value;
    } else if (value == '=') {
      // 处理等号按钮的逻辑
      try {
        // 计算表达式的结果
        final result = calculateResult(inputNum);
        inputNum+='=$result';

        // 将结果保存到历史记录

        /// 将给定的结果数据保存到文件中
        ///
        /// 异步地将字符串结果追加写入到名为'histroy.txt'的文件中如果文件不存在，
        /// 它将被创建此方法用于记录操作历史或保存临时数据，以便后续访问或查看
        Future<void> saveData(String result,String inputNum) async {
          try {
            final directory = await getApplicationDocumentsDirectory();
            final file = File('${directory.path}/history.txt');
            // print('文件路径：$file');
            await file.writeAsString('$inputNum\n', mode: FileMode.append);
          } catch (e) {
            // 错误处理
            if (kDebugMode) {
              print('Error saving data: $e');
            }
          }
        }
        saveData(result, inputNum);
        // 打印结果（调试用）
        if (kDebugMode) {
          print('Result: $result');
        }
      } catch (e) {
        // 处理计算错误
        inputNum = 'Error';
        if (kDebugMode) {
          print('Error result: $e');
        }
      }
    } else if(value == 'C'){
      try{
        inputNum = '';
      }catch(e){
        if (kDebugMode) {
          print('Error clear data: $e');
        }
      }
    }else if(value == 'D'){
      try{
        inputNum = inputNum.substring(0, inputNum.length - 1);
      }catch(e){
        if (kDebugMode) {
          print('Error deleting data: $e');
        }
      }
    }
    else {
      // 处理其他按钮的逻辑
      inputNum += value;
    }

    // 打印当前输入的表达式（调试用）
    if (kDebugMode) {
      print(inputNum);
    }
    // 通知监听者更新界面
    notifyListeners();
  }

  String calculateResult(String expression) {
    try {
      if (kDebugMode) {
        print(expression);
      }
      return evaluateExpression(expression).toString();
    } catch (e) {
      return "Error";
    }
  }

  /// 计算并返回作为字符串提供的数学表达式的结果，结果类型为double
  /// 表达式中可以包含数字、运算符以及括号
  ///
  /// @param expression 表达式的字符串表示形式
  double evaluateExpression(String expression) {
    // 将表达式分解成标记列表
    List<String> expressions = slipExpression(expression);

    // 初始化两个栈，一个用于存储数值，另一个用于存储运算符
    List<double> values = [];
    List<String> operators = [];

    // 遍历所有标记
    for (String value in expressions) {
      // 如果标记是数字，转换为double类型,存储在数值列表
      if (isNumber(value)) {
        values.add(double.parse(value));
        // 如果标记是左括号，压入运算符列表
      } else if (value == '(') {
        operators.add(value);
        // 如果标记是右括号，执行运算直到遇到左括号
      } else if (value == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          values.add(applyOperator(values.removeLast(), values.removeLast(), operators.removeLast()));
        }
        operators.removeLast(); // 移除左括号
        // 如果标记是运算符，根据优先级执行运算
      } else if (isOperator(value)) {
        while (operators.isNotEmpty &&
            precedence(operators.last) >= precedence(value)) {
          values.add(applyOperator(values.removeLast(), values.removeLast(), operators.removeLast()));
        }
        operators.add(value);
      }
    }

    // 处理剩余的运算符
    while (operators.isNotEmpty) {
      values.add(applyOperator(values.removeLast(), values.removeLast(), operators.removeLast()));
    }

    return values.last;
  }


  /// 对表达式进行分词
  ///
  /// 将输入的数学表达式分割成数字和运算符（包括括号）的列表
  /// 数字可以是单个字符或多个字符的连续序列，运算符和括号各自作为单独的令牌
  ///
  /// @param expression 待分词的数学表达式字符串
  /// @return 一个包含数字和运算符（包括括号）的字符串列表
  List<String> slipExpression(String expression) {
    // 用于存储分词后的结果
    List<String> nums = [];
    // 用于临时存储连续的数字字符
    String numberBuffer = '';

    // 遍历表达式中的每个字符
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      // 如果当前字符是括号或运算符，则将当前数字缓冲区的内容添加到列表中，
      // 并将当前字符作为一个单独的元素添加到列表中
      if (char == '(' || char == ')' || isOperator(char)) {
        if (numberBuffer.isNotEmpty) {
          nums.add(numberBuffer);
          numberBuffer = '';
        }
        nums.add(char);
      } else {
        // 如果当前字符是数字，则将其添加到数字区
        numberBuffer += char;
      }
    }

    // 处理表达式遍历完成后剩余的数字缓冲区内容
    if (numberBuffer.isNotEmpty) {
      nums.add(numberBuffer);
    }

    return nums;
  }


  bool isNumber(String value) {
    return double.tryParse(value) != null;
  }

  bool isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷';
  }

  //优先级
  int precedence(String operator) {
    if (operator == '+' || operator == '-') {
      return 1;
    } else if (operator == '×' || operator == '÷') {
      return 2;
    }
    return 0;
  }

  double applyOperator(double a, double b, String operator) {
    if (operator == '+') {
      return a + b;
    } else if (operator == '-') {
      return b - a;
    } else if (operator == '×') {
      return a * b;
    } else if (operator == '÷') {
      return a / b;
    }
    throw Exception('Unknown operator');
  }
}
