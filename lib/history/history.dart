import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> _history = [];
  final ScrollController scrollController = ScrollController();

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
        // 延迟执行，确保列表内容加载后再滚动
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
      }
    } catch (e) {
      // 错误处理
      if (kDebugMode) {
        print('加载历史数据时出错: $e');
      }
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      controller: scrollController,
      children: _history.map((result) {
        return ListTile(
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(result),
          ),
        );
      }).toList(),
    );
  }
}
