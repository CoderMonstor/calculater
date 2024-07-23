import 'drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: OpenDrawer(),
        drawer: const DrawerDemo(),
        endDrawer: const DrawerDemo(),
      ),
    );
  }
}

class OpenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: const Text('呼出左侧侧边栏'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Custom Snackbar'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text('呼出右侧侧边栏'),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}
