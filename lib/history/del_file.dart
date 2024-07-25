import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DelHistoryFile{
  // 删除历史记录
  static Future<void> deleteHistoryFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/history.txt');

      bool fileExists = await file.exists();
      if (fileExists) {
        await file.delete();
        if (kDebugMode) {
          debugPrint('文件已成功删除.');
        }
      } else {
        if (kDebugMode) {
          debugPrint('文件不存在，无需删除.');
        }
      }
    }catch(e){
      if (kDebugMode) {
        debugPrint('文件操作失败: $e');
      }
    }
  }
}