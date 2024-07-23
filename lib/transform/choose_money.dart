import 'jump_to_listPage.dart';
import 'package:flutter/material.dart';
class ChooseMoney extends StatefulWidget {
  const ChooseMoney({super.key});

  @override
  State<ChooseMoney> createState() => _ChooseMoneyState();
}

class _ChooseMoneyState extends State<ChooseMoney> {
  final JumpToTransformListPage _jumpToTransformListPage = JumpToTransformListPage();
  String? _selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: Text(_selectedCurrency ?? '美元 USD'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final result = await _jumpToTransformListPage.jumpToTransformListPage(context);
        if (result != null) {
          setState(() {
            _selectedCurrency = result;
          });
        }
      },
    );
  }
}