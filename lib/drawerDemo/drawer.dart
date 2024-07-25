import 'package:calculater/history/history.dart';
import '../history/del_history_demo.dart';
import 'package:flutter/material.dart';

class DrawerDemo extends StatefulWidget{
  const DrawerDemo({super.key});

  @override
  State<DrawerDemo> createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<DrawerDemo> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
          children: <Widget>[
            const Column(
              children: <Widget>[
                // 用户账号抽屉头部
                UserAccountsDrawerHeader(
                  accountName: Text("lmy"),
                  accountEmail:Text("lmy@163.com"),
                  //当前用户的头像
                  currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('assets/images/1.jpg'),),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/10.jpg'
                        ),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Column(
                  children: [
                    DeleteHistoryDemo(),
                    SizedBox(
                      width: 400,
                      height: 500,
                      child: History(),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                bottom: 10,
                right: 10,
                // 退出按钮，InkWell是可以添加点击事件的容器
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



