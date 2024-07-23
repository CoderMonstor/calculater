import 'dart:io';

import 'package:calculater/Login/login.dart';
import 'package:calculater/about/details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SettingPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  const SettingPage({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  String _selectedLanguage = '中文'; // 当前选中的语言

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        actions: const [
          SizedBox(
              width: 100,
              child: Icon(Icons.person)),
        ],
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
            buildExit(context),
            buildAbout(context),
            ListTile(
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
            )
          ],
        ),
      ),
    );
  }

  ListTile buildDelHistory() {
    return ListTile(
            title: const Text('清除历史记录'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                // 清除历史记录
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return const LoginPage();
                    },
                  ),
                );
              }
            )
          );
  }

  ListTile buildAgreement() {
    return ListTile(
            title: const Text('用户协议'),
            trailing: GestureDetector(
              onTap: () {

              },
              child: Image.asset("assets/images/logo.png"),
            ),
          );
  }

  ListTile buildPrimary() {
    return ListTile(
            title: const Text('隐私政策'),
            trailing: IconButton(
                onPressed: (){

                },
                icon: const Icon(Icons.open_in_new)),
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
}

