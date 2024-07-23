import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


class DeleteHistory extends StatefulWidget {
  const DeleteHistory({super.key});

  @override
  State<DeleteHistory> createState() => _DeleteHistoryState();
}

class _DeleteHistoryState extends State<DeleteHistory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListTile(
        title: const Text("删除所有历史记录", style: TextStyle(fontSize: 30)),
        trailing: IconButton(
            icon: const Icon(Icons.delete_outline_sharp),
            onPressed: () async {
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
                } on PlatformException catch (e) {
                  if (kDebugMode) {
                    debugPrint('文件操作失败: $e');
                  }
                }
              }
        ),
      ),
    );
  }
}
