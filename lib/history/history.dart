import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class History extends StatefulWidget {


  // final String inputNum;
  // final String result;

  const History({super.key});


  @override
  State<History> createState() => _HistoryState();

}

class _HistoryState extends State<History> {
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<Directory> _getDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  Future<File> _getHistoryFile() async {
    final directory = await _getDirectory();
    return File('${directory.path}/history.txt');
  }

  Future<void> _loadHistory() async {
    try {
      final file = await _getHistoryFile();
      if (await file.exists()) {
        final data = await file.readAsString();
        setState(() {
          _history = data.split('\n').where((line) => line.isNotEmpty).toList();
        });
      }
    } catch (e) {
      // 错误处理
      if (kDebugMode) {
        print('加载历史数据时出错: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      children: _history.map((result) {
        return ListTile(
          // leading: const Icon(Icons.history),
          title: Align(
              alignment: Alignment.centerRight,
              child: Text(result)
          ),
          // subtitle: Text(result),
          // trailing: IconButton(
          //   icon: const Icon(Icons.delete),
          //   onPressed: () {
          //     setState(() {
          //       _history.remove(result);
          //     });
          //   },
          // ),
        );
      }).toList(),
    );
  }
}
