import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Office Layout'),
        ),
        body: Center(
          child: OfficeLayout(),
        ),
      ),
    );
  }
}

class OfficeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 您可以根据需要调整尺寸
      height: 400,
      decoration: BoxDecoration(
        color: Colors.purple[100],
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Stack(
        children: [
          // 文件柜
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // 桌子
          Positioned(
            bottom: 50,
            left: 50,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.brown.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // 可以用Icon或其他Widget表示文件
                    Icon(Icons.ac_unit_rounded, size: 30),
                    // 笔记本电脑（这里用Container模拟）
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('Laptop', style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}