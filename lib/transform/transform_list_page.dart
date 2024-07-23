import 'config.dart';
import 'package:flutter/material.dart';

class TransformListPage extends StatelessWidget {
  const TransformListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("选择币种"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 搜索功能
            },
          ),
        ],
      ),
      body: const TransformList(),
    );
  }
}

class TransformList extends StatefulWidget {
  const TransformList({super.key});

  @override
  State<TransformList> createState() => _TransformListState();
}

class _TransformListState extends State<TransformList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: financeNames.map((currency){
        return ListTile(
          title: Text(currency),
          onTap: () {
            Navigator.of(context).pop(currency);
          },
        );
      }).toList(),
    );
  }
}
