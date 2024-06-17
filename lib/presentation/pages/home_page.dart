import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../state/bottom_nav_index_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final bottomNavIndexState = Provider.of<BottomNavIndexState>(context);
    return Scaffold(
      body: AppStyles.mainPages[bottomNavIndexState.getIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: bottomNavIndexState.getIndex,
        onTap: (index) => bottomNavIndexState.setIndex = index,
        selectedItemColor: appColors.primary,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_alarm_outlined),
            title: const Text(AppStrings.tasks),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.task_alt_rounded),
            title: const Text(AppStrings.habits),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.auto_graph),
            title: const Text(AppStrings.graphics),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text(AppStrings.settings),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.info_outline),
            title: const Text(AppStrings.aboutUs),
          ),
        ],
      ),
    );
  }
}
