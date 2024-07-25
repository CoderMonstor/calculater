import 'dart:async';
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
  Timer? _timer;
  late File _historyFile;
  late DateTime _lastModified;

  @override
  void initState() {
    super.initState();
    _initializeHistory();
    _startFileWatcher();
  }

  @override
  void dispose() {
    _timer?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeHistory() async {
    _historyFile = await _getHistoryFile();
    if (await _historyFile.exists()) {
      _lastModified = await _historyFile.lastModified();
      await _loadHistory();
    } else {
      _lastModified = DateTime.now();
    }
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
      if (await _historyFile.exists()) {
        final data = await _historyFile.readAsString();
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

  void _startFileWatcher() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (await _historyFile.exists()) {
        final newModified = await _historyFile.lastModified();
        if (newModified.isAfter(_lastModified)) {
          _lastModified = newModified;
          await _loadHistory();
        }
      } else {
        // 文件不存在，取消定时器并更新UI
        _timer?.cancel();
        setState(() {
          _history = [];
        });
        _startFileExistenceChecker();
      }
    });
  }

  void _startFileExistenceChecker() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (await _historyFile.exists()) {
        _timer?.cancel();
        _initializeHistory();
        _startFileWatcher();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _history.isEmpty
        ? const Center(
          child: Text(' ',),
        )
        : ListView(
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
