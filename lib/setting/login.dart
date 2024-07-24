import 'package:calculater/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 获取屏幕的可见区域的高度
          final screenHeight = MediaQuery.of(context).size.height;
          // 获取键盘的高度
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

          // 计算实际可用的页面高度
          final availableHeight = screenHeight - keyboardHeight;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: availableHeight, // 设置最小高度为实际可用高度
              ),
              child: IntrinsicHeight(
                child: Center(
                  child: SizedBox(
                    width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: '用户名',
                            hintText: '请输入用户名',
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: '密码',
                            hintText: '请输入密码',
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return MyHomePage(
                                    isDarkMode: false,
                                    onThemeChanged: (value) {
                                      setState(() {
                                      });
                                    },
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text('登录'),
                        ),
                        const SizedBox(
                          height: 250,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
