import 'dart:async';

import 'package:calculater/history/del_file.dart';

import 'details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  const SettingPage({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _selectedLanguage = '中文'; // 当前选中的语言
  late Timer timer;
  bool isDialogShown = false; // 用于跟踪对话框是否已经显示过

  @override
  void initState() {
    super.initState();
    // 设置定时器间隔为 3 秒，避免过于频繁的触发
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!isDialogShown) {
        try {
          myDialog(); // 显示对话框
        } catch (e) {
          if (kDebugMode) {
            debugPrint('定时器错误: $e');
          }
        }
      }
    });
  }
  @override
  void dispose() {
    timer.cancel(); // 取消定时器以避免内存泄漏
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: const DrawerDemo(),
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: SizedBox(
        child: ListView(
          children: [
            buildTheme(),
            buildLanguage(),
            buildVersion(),
            // buildPrimary(),
            buildDelHistory(),
            // buildAgreement(),
            buildAbout(context),
            buildDetails(context),
            buildExit(context),
          ],
        ),
      ),
    );
  }

  ListTile buildDetails(BuildContext context) {
    return ListTile(
            title: const Text('详细介绍'),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return const DetailsPage();
                    },
                  )
                );
              },
              child: Hero(
                  tag: 'imagesHero',
                  child: Image.asset("assets/images/logo.png")),
            ),
          );
  }

  ListTile buildDelHistory() {
    return ListTile(
            title: const Text('清除历史记录'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                // 清除历史记录
                DelHistoryFile.deleteHistoryFile();
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Center(child: Text('提示')),
                        content:const Text("清除成功"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('确定'),
                          ),
                        ],
                      );
                    });
              }
            ),
          );
  }

  ListTile buildAbout(BuildContext context) {
    return ListTile(
            title: const Text('关于'),
            trailing: IconButton(
                onPressed: (){
                  // showDialog(
                  //   context: context,
                  //   builder: (ctx) {
                  //     return AlertDialog(
                  //       title: const Center(child: Text('关于')),
                  //       content:const Text("这是一个简单的计算器"),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: const Text('确定'),
                  //         ),
                  //       ],
                  //     );
                  //  },
                  // );
                  showAboutDialog(
                    context: context,
                    applicationName: 'Calculator',
                    applicationVersion: '1.0.0',
                    applicationIcon: Image.asset('assets/images/logo.png'),
                    applicationLegalese: 'Copyright © 2024',
                  );
                },
                icon: const Icon(Icons.info)),
          );
  }

  ListTile buildExit(BuildContext context) {
    return ListTile(
            title: const Text('退出'),
            trailing: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                // 退出登录
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (ctx) {
                //       return const LoginPage();
                //     },
                //   ),
                // );
                //退出整个程序
                SystemNavigator.pop();
              }
            )
          );
  }



  ListTile buildVersion() {
    return const ListTile(
            title: Text('版本'),
            trailing: Text('1.0.0',style: TextStyle(fontSize: 16)),
          );
  }

  ListTile buildLanguage() {
    return ListTile(
            title: const Text('语言'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage, // 绑定当前选中的语言
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue ?? '中文'; // 更新选中的语言
                });
              },
              items: <String>[
                '中文',
                'English',
                '日本語',
                '한국어',
                'Español',
                'Français',
                'Deutsch',
                'Português',
                'Italiano',
                'Русский',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          );
  }

  ListTile buildTheme() {
    return ListTile(
            title: const Text('主题设置'),
            trailing: Switch(
              value: widget.isDarkMode,
              onChanged: (value) {
                setState(() {
                  widget.onThemeChanged(value);
                  // Navigator.pop(context);
                });
              },
            ),
          );
  }

  void myDialog() {
    isDialogShown = true; // 设置对话框显示状态
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 10,
          child: Stack(
            children:[
              Container(
                height: 450,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/adnull.png'),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Positioned(
                bottom: 10,
                left: 130,
                child: IconButton(
                  //背景透明
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 30,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon:const Icon(Icons.cancel)),
              ),
            ]
          ),
        );
      },
    );// 确保在对话框关闭时重置状态;
  }
  ///待实现
  ///
///   ListTile buildAgreement() {
//     return ListTile(
//             title: const Text('用户协议'),
//             trailing: GestureDetector(
//               onTap: () {
//
//               },
//               child: Image.asset("assets/images/logo.png"),
//             ),
//           );
//   }

//  ListTile buildPrimary() {
//     return ListTile(
//             title: const Text('隐私政策'),
//             trailing: IconButton(
//                 onPressed: (){
//
//                 },
//                 icon: const Icon(Icons.open_in_new)),
//           );
//   }

}

