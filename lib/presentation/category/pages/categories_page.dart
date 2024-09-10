import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/enums/task_period.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/create_task_args.dart';
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
          AddCategoryButton(),
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
          TaskCategoriesList(taskPeriodIndex: TaskPeriod.day.index),
          TaskCategoriesList(taskPeriodIndex: TaskPeriod.week.index),
          TaskCategoriesList(taskPeriodIndex: TaskPeriod.month.index),
          TaskCategoriesList(taskPeriodIndex: TaskPeriod.season.index),
          TaskCategoriesList(taskPeriodIndex: TaskPeriod.year.index),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: appLocale.addTask,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            NameRoutes.createTaskPage,
            arguments: CreateTaskArgs(
              taskPeriodIndex: _tabController.index,
            ),
          );
        },
      ),
    );
  }
}
