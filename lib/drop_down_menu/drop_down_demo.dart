// import 'package:calculater/transform/config.dart';
// import 'package:flutter/material.dart';
//
// class DropdownMenuDemo extends StatefulWidget {
//   final Function(String)? onChanged; // 回调函数
//
//   const DropdownMenuDemo({super.key,this.onChanged});
//
//   @override
//   State<DropdownMenuDemo> createState() => _DropdownMenuDemoState();
// }
//
// class _DropdownMenuDemoState extends State<DropdownMenuDemo> {
//   late String _dropdownValue = financeNames.first;
//   late String _selectedValue;
//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu<String>(
//       label: Text(_selectedValue),
//       menuHeight: 200,
//       width: 100,
//       initialSelection: financeNames.first,
//       onSelected: _onSelect,
//       /// 构建下拉菜单的条目列表。
//       ///
//       /// 根据提供的数据，生成适用于下拉菜单的条目列表。每个条目代表菜单中的一项选择。
//       /// 使用此方法可以动态地根据数据源生成菜单项，从而提供灵活的用户界面选项。
//       dropdownMenuEntries: _buildMenuList(financeNames),
//
//     );
//   }
//
//   void _onSelect(String? value) {
//     setState(() {
//       _dropdownValue = value!;
//     });
//   }
//
//   List<DropdownMenuEntry<String>> _buildMenuList(List<String> data) {
//     return data.map((String value) {
//       return DropdownMenuEntry<String>(value: value, label: value);
//     }).toList();
//   }
// }




// import 'package:calculater/transform/config.dart';
// import 'package:flutter/material.dart';
//
// class DropdownMenuDemo extends StatefulWidget {
//   final Function(String)? onChanged; // 回调函数
//
//   const DropdownMenuDemo({super.key, this.onChanged});
//
//   @override
//   State<DropdownMenuDemo> createState() => _DropdownMenuDemoState();
// }
//
// class _DropdownMenuDemoState extends State<DropdownMenuDemo> {
//   late String _dropdownValue = financeNames.first;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: _dropdownValue,
//       items: _buildMenuList(financeNames),
//       onChanged: (String? newValue) {
//         setState(() {
//           _dropdownValue = newValue!;
//         });
//         widget.onChanged?.call(newValue!);
//       },
//     );
//   }
//
//   List<DropdownMenuItem<String>> _buildMenuList(List<String> data) {
//     return data.map((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     }).toList();
//   }
// }

import 'package:calculater/transform/config.dart';
import 'package:flutter/material.dart';

class DropdownMenuDemo extends StatefulWidget {
  final Function(String)? onChanged; // 回调函数

  const DropdownMenuDemo({super.key, this.onChanged});

  @override
  State<DropdownMenuDemo> createState() => _DropdownMenuDemoState();
}

class _DropdownMenuDemoState extends State<DropdownMenuDemo> {
  late String _dropdownValue = financeNames.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _dropdownValue,
      items: _buildMenuList(financeNames),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownValue = newValue!;
        });
        widget.onChanged?.call(newValue!);
      },
    );
  }

  List<DropdownMenuItem<String>> _buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}