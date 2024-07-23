import 'transform_list_page.dart';
import 'package:flutter/material.dart';

class JumpToTransformListPage {
  Future<String?> jumpToTransformListPage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const TransformListPage(),
      ),
    );
  }
}
