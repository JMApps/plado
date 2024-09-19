import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/styles/app_styles.dart';
import '../state/bottom_nav_index_state.dart';
import '../widgets/main_bottom_item_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final bottomNavIndexState = Provider.of<BottomNavIndexState>(context);
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: AppStyles.mainPages[bottomNavIndexState.getIndex],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: bottomNavIndexState.getIndex,
        onTap: (index) => bottomNavIndexState.setIndex = index,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.check_circle_outline_rounded),
            title: MainBottomItemText(itemText: appLocale.tasks),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.access_time),
            title: MainBottomItemText(itemText: appLocale.habits),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.query_stats_outlined),
            title: MainBottomItemText(itemText: appLocale.statistics),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings_outlined),
            title: MainBottomItemText(itemText: appLocale.settings),
          ),
        ],
      ),
    );
  }
}
