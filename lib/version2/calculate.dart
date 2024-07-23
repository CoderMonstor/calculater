import 'package:calculater/result/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Calculator extends ChangeNotifier{

  String inputNum = '';
  String result = '';


  void onButtonPressed(String value) {
    // 如果第一个输入的是操作符，则不进行任何操作
    if (inputNum.isEmpty && isOperator(value)) {
      return;
    }

    // 如果当前输入的是操作符，并且前一个字符也是操作符，则替换掉前一个操作符
    if (isOperator(value) && inputNum.isNotEmpty && isOperator(inputNum[inputNum.length - 1])) {
      inputNum = inputNum.substring(0, inputNum.length - 1) + value;
    } else {
      inputNum += value;
    }

    // 打印当前输入的表达式（调试用）
    if (kDebugMode) {
      print(inputNum);
    }
    notifyListeners();
  }

  /// 当等于号按钮被按下时执行的操作。
  ///
  /// 该方法负责计算输入数字的结果，将用户导航到显示结果的页面。
  /// 在调试模式下，还会打印计算结果到控制台。
  ///
  /// @param context Flutter构建上下文，用于导航到结果页面。
  void equalPressed(BuildContext context) {
    // 计算输入数字的结果。
    result = calculateResult(inputNum);

    // 延迟0毫秒后，执行跳转到结果页面的操作。这是为了确保UI线程可以先处理其他更新。
    Future.delayed(Duration.zero, () {
      jumpToResultPage(context, result);
    });

      print(result);

  }


// 计算结果
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

  /// 计算给定表达式的值。
  ///
  /// 首先对输入的表达式进行标记化，然后通过迭代每个标记来处理数字和运算符，
  ///
  /// @param expression 要评估的数学表达式字符串。
  /// @return 表达式的计算结果。
  int evaluateExpression(String expression) {
    // 将表达式分割成标记列表，这些标记可以是数字或运算符。
    List<String> numberLists = inputRealize(expression);
    // 存储操作数
    List<int> numbers = [];
    // 存储运算符
    List<String> operators = [];

    // 遍历每个标记。
    for (String lists in numberLists) {
      // 判断当前标记是否为运算符。
      if (isOperator(lists)) {
        // 当栈不为空且栈顶运算符的优先级不小于当前运算符的优先级时，执行运算。
        while (operators.isNotEmpty && precedence(operators.last) >= precedence(lists)) {
          // 弹出操作数和运算符进行计算，并将结果压回操作数栈。
          int b = numbers.removeLast();
          int a = numbers.removeLast();
          String op = operators.removeLast();
          numbers.add(applyOperator(a, b, op));
        }
        // 将当前运算符压入运算符栈。
        operators.add(lists);
      } else {
        // 如果当前标记是数字，则将其转换为整数并压入操作数栈。
        numbers.add(int.parse(lists));
      }
    }

    // 处理剩余的运算符，这些运算符可能是左括号或优先级较低的运算符。
    while (operators.isNotEmpty) {
      // 弹出操作数和运算符进行计算，并将结果压回操作数栈。
      int b = numbers.removeLast();
      int a = numbers.removeLast();
      String op = operators.removeLast();
      numbers.add(applyOperator(a, b, op));
    }

    // 返回最终的结果，即操作数栈中的最后一个元素。
    return numbers.last;
  }

  /// 将输入的表达式字符串分解为运算符和数字的列表。
  ///
  /// 该函数遍历表达式字符串，将数字和运算符分开，并将它们分别添加到结果列表中。
  /// 数字可能由一个或多个字符组成，而运算符则单独处理。
  ///
  /// @param expression 表达式字符串，包含数字和运算符。
  /// @return 一个包含数字和运算符的字符串列表。
  List<String> inputRealize(String expression) {
    // 用于存储分解后的表达式的列表，其中包含数字和运算符。
    List<String> numbers = [];
    // 用于临时存储数字的字符串缓冲区。
    String numberBuffer = '';

    // 遍历表达式字符串的每个字符。
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      // 如果当前字符是运算符。
      if (isOperator(char)) {
        // 如果数字缓冲区中存在数字，则将其作为单独的元素添加到numbers列表中。
        if (numberBuffer.isNotEmpty) {
          numbers.add(numberBuffer);
          numberBuffer = '';
        }
        // 将运算符添加到numbers列表中。
        numbers.add(char);
      } else {
        // 如果当前字符是数字，则将其追加到数字缓冲区。
        numberBuffer += char;
      }
    }
    // 如果数字缓冲区中还有剩余的数字，则将其添加到列表中。
    if (numberBuffer.isNotEmpty) {
      numbers.add(numberBuffer);
    }

    // 返回分解后的表达式列表。
    return numbers;
  }


  bool isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷';
  }

  int precedence(String operator) {
    if (operator == '+' || operator == '-') {
      return 1;
    } else if (operator == '×' || operator == '÷') {
      return 2;
    }
    return 0;
  }

  int applyOperator(int a, int b, String operator) {
    if (operator == '+') {
      return a + b;
    } else if (operator == '-') {
      return a - b;
    } else if (operator == '×') {
      return a * b;
    } else if (operator == '÷') {
      return a ~/ b;
    }
    throw Exception('Unknown operator');
  }

  void clearButton() {
      inputNum = '';
      result = '';
      notifyListeners();
  }
  void jumpToResultPage(BuildContext context, String result) {

    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx){
          return ResultPage(result,inputNum);
        }));
  }
}





