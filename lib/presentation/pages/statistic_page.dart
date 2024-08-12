import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../statistic/items/main_statistic_item.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.statistics),
      ),
      body: const MainStatisticItem(),
    );
  }
}
