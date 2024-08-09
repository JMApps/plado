import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../graphic/items/main_graphic_item.dart';

class GraphicsPage extends StatelessWidget {
  const GraphicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.graphics),
      ),
      body: const MainGraphicItem(),
    );
  }
}
