import 'package:calculater/history/history.dart';
import '../history/del_history.dart';
import 'package:flutter/material.dart';

class DrawerDemo extends StatefulWidget{
  const DrawerDemo({super.key});

  @override
  State<DrawerDemo> createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<DrawerDemo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        elevation: 16.0,
        child: Stack(
          children: <Widget>[
            const Column(
              children: <Widget>[
                // 用户账号抽屉头部
                UserAccountsDrawerHeader(
                  accountName: Text("lmy"),
                  accountEmail:Text("lmy@163.com"),
                  currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('assets/images/1.jpg'),),
                  arrowColor: Colors.red,
                  // onDetailsPressed: () {
                  //   print(1);
                  // },
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/bg.jpg'
                        ),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      DeleteHistory(),
                      SizedBox(
                        width: 400,
                        height: 500,
                        child: History(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: InkWell(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('退出'),
                      IconButton(
                        icon: Icon(Icons.power_settings_new),
                        onPressed: null,
                      ),
                    ],
                  ),
                  onTap: () => Navigator.pop(context),
                )
            )
          ],
        )
    );
  }
}



