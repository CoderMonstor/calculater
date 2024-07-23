import 'package:calculater/drawerDemo/drawer.dart';
import 'package:calculater/drop_down_menu/drop_down_demo.dart';
import 'package:calculater/drop_down_menu/drop_down_page.dart';
import 'package:flutter/material.dart';
import 'package:calculater/widget/calc_show.dart';
import 'package:calculater/widget/calculate.dart';
import 'package:provider/provider.dart';
import 'transform/transform_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Calculator(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // 用于跟踪当前主题的变量

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Demo',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // 应用选择的主题
      home: MyHomePage(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const MyHomePage({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Calculator calculator = Calculator(); // 声明 Calculator 对象

  @override
  void initState() {
    super.initState();
    calculator = Calculator(); // 初始化 Calculator 对象
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('计算器'),
            // centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(widget.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
                onPressed: widget.toggleTheme,
              ),
            ],
          ),
          // body: const NumButtons(), // 将 Calculator 对象传递给 NumButtons
            body: TabBarView(
              children: choices.map((Choice choice) {
                switch (choice.icon) {
                  case Icons.calculate:
                    return const NumButtons();
                  case Icons.currency_exchange:
                    return const TransformPage();
                  case Icons.bookmark_border:
                    return const DropDownPage();
                  default:
                    return const NumButtons();
                }
              }).toList(),
            ),
          drawer: const DrawerDemo(),
      )
    );
  }
}


class Choice{
  const Choice({required this.icon});
  // final String title;
  final IconData icon;
}


const List<Choice> choices = [
  Choice(icon: Icons.calculate),
  Choice(icon: Icons.currency_exchange),
  Choice(icon: Icons.bookmark_border)
];