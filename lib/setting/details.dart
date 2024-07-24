import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('软件介绍'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      // color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Hero(
                            tag: 'imagesHero',
                            child: Image.asset("assets/images/logo.png")),

                  )
              ),
              const Positioned(
                  top: 25,
                  right: 15,
                  child: SizedBox(
                    width:150,
                    height: 80,
                    // decoration: BoxDecoration(
                    //   color: Colors.brown.shade300,
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Calculator',style: TextStyle(fontSize: 20),),
                        Text('1.0.0'),
                        Text('Copyright © 2024'),
                      ],
                    ),
                  )),
              Positioned(
                bottom: 50,
                left: 50,
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    // color: Colors.brown.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child:const Text("返回",style: TextStyle(fontSize: 20),),
                        ),
                    ],
                  )
                )
              ),
              Positioned(
                top: 150,
                left: 20,
                child: Container(
                  width: 260,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Scrollable(
                    axisDirection: AxisDirection.down,
                    viewportBuilder: (context, offset) {
                      return const SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("       计算器是一种用于执行数学计算的电子设备或软件应用程序。"
                                "现代计算器不仅能进行基本的算术运算（如加法、减法、乘法和除法），"
                                "还可以执行更复杂的数学函数，包括指数、对数、三角函数、统计运算和编程功能等。"
                                "计算器有多种形式，从简单的便携式设备到功能强大的科学计算器、"
                                "图形计算器，以及嵌入在计算机和智能手机中的应用程序。"
                                "\n        一个典型的计算器界面通常包含一个显示屏和一组按键。"
                                "显示屏用于显示输入的数字和计算结果，"
                                "按键包括数字键、运算符键（如加号、减号、乘号、除号）、"
                                "功能键（如平方根、百分比、记忆功能）"
                                "和控制键（如清除、等号）。高级计算器还可能具有编程接口、方程求解、"
                                "绘制图形和数据分析等功能。"
                                "计算器的使用极为广泛，从学生学习基础数学到科学家进行复杂的工程计算，"
                                "它都是不可或缺的工具。"
                                "\n        随着技术的进步，计算器的功能也在不断扩展，变得更加智能和用户友好。"
                                "例如，智能手机上的计算器应用程序通常不仅"
                                "具有强大的计算功能，还可以与其他应用程序集成，提供更加全面的计算体验。"
                            )
                          ]
                        )
                      );
                    }
                  ),
                                    ),
                  )

            ],
          ),
          ),
      ),
    );
  }
}
