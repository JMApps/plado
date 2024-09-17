import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/enums/category_period.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/styles/app_styles.dart';
import '../addchange/add_category_bottom_sheet.dart';
import '../lists/categories_list.dart';
import '../widgets/sort_category_button.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.appName),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              NameRoutes.marketPage,
            );
          },
          tooltip: appLocale.purchases,
          icon: Icon(
            Icons.add_shopping_cart_rounded,
            color: appColors.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                NameRoutes.taskTimerPage,
              );
            },
            tooltip: appLocale.timerConcentration,
            icon: Icon(
              Icons.timer_outlined,
              color: appColors.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                NameRoutes.dailyTasksPage,
              );
            },
            tooltip: appLocale.dailyTasks,
            icon: Icon(
              Icons.today_rounded,
              color: appColors.primary,
            ),
          ),
          const SortCategoryButton(),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelPadding: AppStyles.paddingHorVerMini,
          padding: AppStyles.paddingBottomMicro,
          splashBorderRadius: AppStyles.border,
          labelStyle: AppStyles.mainText,
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          tabs: [
            Text(appLocale.day),
            Text(appLocale.week),
            Text(appLocale.month),
            Text(appLocale.season),
            Text(appLocale.year),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CategoriesList(taskPeriodIndex: CategoryPeriod.day.index),
          CategoriesList(taskPeriodIndex: CategoryPeriod.week.index),
          CategoriesList(taskPeriodIndex: CategoryPeriod.month.index),
          CategoriesList(taskPeriodIndex: CategoryPeriod.season.index),
          CategoriesList(taskPeriodIndex: CategoryPeriod.year.index),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              child: AddCategoryBottomSheet(
                periodIndex: _tabController.index,
              ),
            ),
          );
        },
        tooltip: appLocale.addCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}
