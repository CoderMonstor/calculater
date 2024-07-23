import 'dart:io';

import 'del_history.dart';
import 'package:calculater/result/history.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class ResultPage extends StatefulWidget {

  /// ResultPage类用于展示计算结果和输入的数字。
  /// [result]参数用于传递计算结果，[inputNum]参数用于传递输入的数字。
  /// 构造函数接受这两个参数来初始化页面状态。
  final String _inputNum;
  final String _result;

  const ResultPage(this._result, this._inputNum,{super.key});

  /// 将给定的结果数据保存到文件中。
  ///
  /// 异步地将字符串结果追加写入到名为'histroy.txt'的文件中。如果文件不存在，
  /// 它将被创建。此方法用于记录操作历史或保存临时数据，以便后续访问或查看。


  Future<void> saveData(String result,String inputNum) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/history.txt');
      // print('文件路径：$file');
      await file.writeAsString('$inputNum=$result\n', mode: FileMode.append);
    } catch (e) {
      // 错误处理
      print('Error saving data: $e');
    }
  }

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    // 保存数据
    widget.saveData(widget._result, widget._inputNum);

    return Scaffold(
      appBar: AppBar(
        title: const Text("计算结果"),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(width: 300,),
                const Text("计算结果是", style: TextStyle(fontSize: 40)),
                SizedBox(
                  child: Text(widget._result, style: const TextStyle(fontSize: 40)),
                )
              ],
            ),
          ),
          const DeleteHistory(),
          const SizedBox(
            height: 500,
            child: SingleChildScrollView(
                child: History(),
            ),
          ),
        ],
      ),
    );
  }
}


