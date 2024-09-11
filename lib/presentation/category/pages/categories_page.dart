import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/enums/category_period.dart';
import '../../../core/styles/app_styles.dart';
import '../addchange/add_category_button.dart';
import '../lists/task_categories_list.dart';
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
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.appName),
        actions: const [
          SortCategoryButton(),
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
          TaskCategoriesList(taskPeriodIndex: CategoryPeriod.day.index),
          TaskCategoriesList(taskPeriodIndex: CategoryPeriod.week.index),
          TaskCategoriesList(taskPeriodIndex: CategoryPeriod.month.index),
          TaskCategoriesList(taskPeriodIndex: CategoryPeriod.season.index),
          TaskCategoriesList(taskPeriodIndex: CategoryPeriod.year.index),
        ],
      ),
      floatingActionButton: const AddCategoryButton()
    );
  }
}
