import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();

  static Future<void> saveData(String result, String inputNum) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/history.txt');
      await file.writeAsString('$inputNum=$result\n', mode: FileMode.append);
    } catch (e) {
      // 错误处理
      if (kDebugMode) {
        print('保存数据时出错: $e');
      }
    }
  }
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
    return Column(
      children: _history.map((result) {
        return ListTile(
          leading: const Icon(Icons.history),
          title: const Text("result"),
          subtitle: Text(result),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _history.remove(result);
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
