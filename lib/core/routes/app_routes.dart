import 'package:flutter/material.dart';

import '../../data/models/arguments/category_model_args.dart';
import '../../data/models/arguments/habit_model_args.dart';
import '../../data/models/arguments/statistic_task_args.dart';
import '../../data/models/arguments/task_model_args.dart';
import '../../presentation/backup/backup_detail_page.dart';
import '../../presentation/dailytask/pages/create_daily_task_page.dart';
import '../../presentation/dailytask/pages/daily_task_page.dart';
import '../../presentation/dailytask/pages/update_daily_task_page.dart';
import '../../presentation/habit/pages/create_habit_page.dart';
import '../../presentation/habit/pages/habit_detail_page.dart';
import '../../presentation/habit/pages/update_habit_page.dart';
import '../../presentation/market/pages/market_page.dart';
import '../../presentation/statistic/pages/habit_static_detail_page.dart';
import '../../presentation/statistic/pages/statistic_habit_list_page.dart';
import '../../presentation/statistic/pages/statistic_task_list_page.dart';
import '../../presentation/task/pages/create_task_page.dart';
import '../../presentation/task/pages/task_category_page.dart';
import '../../presentation/task/pages/update_task_page.dart';
import '../strings/app_exception_messages.dart';
import 'name_routes.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NameRoutes.marketPage:
        return MaterialPageRoute(
          builder: (_) => const MarketPage(),
        );
      case NameRoutes.dailyTasksPage:
        return MaterialPageRoute(
          builder: (_) => const DailyTaskPage(),
        );
      case NameRoutes.createDailyTaskPage:
        return MaterialPageRoute(
          builder: (_) => const CreateDailyTaskPage(),
        );
      case NameRoutes.updateDailyTaskPage:
        final TaskModelArgs taskModelArgs = routeSettings.arguments as TaskModelArgs;
        return MaterialPageRoute(
          builder: (_) => UpdateDailyTaskPage(taskModel: taskModelArgs.taskModel),
        );
      case NameRoutes.taskCategoryPage:
        final CategoryModelArgs categoryModelArgs = routeSettings.arguments as CategoryModelArgs;
        return MaterialPageRoute(
          builder: (_) => TaskCategoryPage(categoryModel: categoryModelArgs.categoryModel),
        );
      case NameRoutes.createTaskPage:
        final CategoryModelArgs categoryModelArgs = routeSettings.arguments as CategoryModelArgs;
        return MaterialPageRoute(
          builder: (_) => CreateTaskPage(categoryModel: categoryModelArgs.categoryModel),
        );
      case NameRoutes.updateTaskPage:
        final TaskModelArgs taskModelArgs = routeSettings.arguments as TaskModelArgs;
        return MaterialPageRoute(
          builder: (_) => UpdateTaskPage(taskModel: taskModelArgs.taskModel),
        );
      case NameRoutes.createHabitPage:
        return MaterialPageRoute(
          builder: (_) => const CreateHabitPage(),
        );
      case NameRoutes.updateHabitPage:
        final HabitModelArgs habitModelArgs = routeSettings.arguments as HabitModelArgs;
        return MaterialPageRoute(
          builder: (_) => UpdateHabitPage(habitModel: habitModelArgs.habitModel),
        );
      case NameRoutes.habitDetailPage:
        final HabitModelArgs habitModelArgs = routeSettings.arguments as HabitModelArgs;
        return MaterialPageRoute(
          builder: (_) => HabitDetailPage(habitModel: habitModelArgs.habitModel),
        );
      case NameRoutes.statisticTaskListPage:
        final StatisticTaskArgs graphicTaskArgs = routeSettings.arguments as StatisticTaskArgs;
        return MaterialPageRoute(
          builder: (_) => StatisticTaskListPage(statisticTaskArgs: graphicTaskArgs),
        );
      case NameRoutes.statisticHabitListPage:
        return MaterialPageRoute(
          builder: (_) => const StatisticHabitListPage(),
        );
      case NameRoutes.habitStaticDetailPage:
        final HabitModelArgs habitModelArgs = routeSettings.arguments as HabitModelArgs;
        return MaterialPageRoute(
          builder: (_) => HabitStaticDetailPage(habitModel: habitModelArgs.habitModel),
        );
      case NameRoutes.backupDetailPage:
        return MaterialPageRoute(
          builder: (_) => const BackupDetailPage(),
        );
      default:
        throw Exception('${AppExceptionMessages.invalidRouteException} ${routeSettings.name}');
    }
  }
}
