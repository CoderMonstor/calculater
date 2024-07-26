import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//建造者模式？

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  /// 存储浏览历史记录
  List<String> _history = [];
  
  /// 初始化一个滚动控制器
  final ScrollController scrollController = ScrollController();
  
  /// 用于记录上一次修改时间的定时器
  Timer? _timer;
  
  /// 保存历史记录的文件对象，用于持久化存储修改历史
  late File _historyFile;
  
  /// 上一次修改文件的时间，比较和判断是否需要更新文件
  late DateTime _lastModified;

  /// 设置初始状态和启动必要的初始化操作
  @override
  void initState() {
    super.initState();
    _initializeHistory(); // 初始化历史记录
    _startFileWatcher(); // 文件监听
  }
  
  /// 清理资源
  @override
  void dispose() {
    _timer?.cancel(); // 取消计时器，避免内存泄漏
    scrollController.dispose(); // 清理scrollController占用的资源
    super.dispose();
  }

  /// 初始化历史记录
  ///
  /// 获取历史记录文件，并根据文件是否存在来加载历史记录或初始化一个新的历史记录文件
  Future<void> _initializeHistory() async {
    // 获取历史记录文件对象
    _historyFile = await _getHistoryFile();
    // 检查历史记录文件是否存在
    if (await _historyFile.exists()) {
      // 如果文件存在，获取其最后修改时间
      _lastModified = await _historyFile.lastModified();
      // 加载历史记录
      await _loadHistory();
    } else {
      // 如果文件不存在，设置当前时间为最后修改时间
      _lastModified = DateTime.now();
    }
  }


  /// 获取应用程序文档目录的异步方法
  /// 
  /// 此方法用于获取应用程序的文档目录，存储应用程序的数据
  /// 返回一个Future，该Future解析为Directory对象，表示应用程序文档目录
  Future<Directory> _getDirectory() async {
    // 等待并返回获取应用程序文档目录的结果
    return await getApplicationDocumentsDirectory();
  }

  /// 获取历史记录文件的异步方法
  /// 
  /// 此方法通过首先获取应用程序文档目录，然后在该目录中创建或获取一个名为“history.txt”的文件来工作
  /// 返回一个Future，该Future解析为File对象，表示名为“history.txt”的文件
  Future<File> _getHistoryFile() async {
    // 获取应用程序文档目录
    final directory = await _getDirectory();
    // 在文档目录中创建或获取名为“history.txt”的文件
    return File('${directory.path}/history.txt');
  }


  /// 加载历史记录
  ///
  /// 从文件中加载历史记录，并更新UI显示  如果文件存在且读取成功
  /// 则将文件内容分割为多行，并过滤掉空行，然后更新历史记录列表
  /// 如果在加载过程中发生错误，只有在调试模式下才会打印错误信息
  Future<void> _loadHistory() async {
    try {
      if (await _historyFile.exists()) {
        final data = await _historyFile.readAsString();
        // 更新状态，刷新UI，显示历史记录
        setState(() {
          // 将字符串内容按行分割，并过滤掉空行
          _history = data.split('\n').where((line) => line.isNotEmpty).toList();
        });
        // 延迟执行，确保列表内容加载后再滚动到最底部
        // 延迟执行，确保列表内容加载后再滚动
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
      }
    } catch (e) {
      // 在调试模式下，打印加载历史记录时的错误信息
      if (kDebugMode) {
        print('加载历史数据时出错: $e');
      }
    }
  }


  /// 动画滚动到ScrollController的最底端
  ///
  /// 此方法用于在某些滚动视图中，平滑地将视图滚动到最底部
  void scrollToBottom() {
    // 使用动画控制器的animateTo方法，平滑地滚动到最大滚动范围（即最底端）
    // 指定动画持续时间为300毫秒，曲线为easeOut
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
