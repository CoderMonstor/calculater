import 'package:flutter/material.dart';
import 'del_file.dart';

class DeleteHistoryDemo extends StatefulWidget {
  const DeleteHistoryDemo({super.key});

  @override
  State<DeleteHistoryDemo> createState() => _DeleteHistoryDemoState();
}

class _DeleteHistoryDemoState extends State<DeleteHistoryDemo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListTile(
        title: const Text("删除所有历史记录", style: TextStyle(fontSize: 30)),
        trailing: IconButton(
            icon: const Icon(Icons.delete_outline_sharp),
            onPressed: () async {
                DelHistoryFile.deleteHistoryFile();
              }
        ),
      ),
    );
  }
}
