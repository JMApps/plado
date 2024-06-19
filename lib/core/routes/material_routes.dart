import 'package:flutter/material.dart';

import '../../data/models/arguments/add_task_args.dart';
import '../../presentation/habit/pages/add_habit_page.dart';
import '../../presentation/habit/pages/update_habit_page.dart';
import '../../presentation/task/pages/add_task_page.dart';
import '../../presentation/task/pages/update_task_page.dart';
import '../strings/app_exception_messages.dart';
import 'name_routes.dart';

class MaterialRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NameRoutes.createTaskPage:
        final AddTaskArgs addTaskArgs = routeSettings.arguments as AddTaskArgs;
        return MaterialPageRoute(
          builder: (_) => AddTaskPage(timeModeIndex: addTaskArgs.timeModeIndex),
        );
      case NameRoutes.updateTaskPage:
        return MaterialPageRoute(
          builder: (_) => const UpdateTaskPage(),
        );
      case NameRoutes.createHabitPage:
        return MaterialPageRoute(
          builder: (_) => const AddHabitPage(),
        );
      case NameRoutes.updateHabitPage:
        return MaterialPageRoute(
          builder: (_) => const UpdateHabitPage(),
        );
      default:
        throw Exception('${AppExceptionMessages.invalidRouteException} ${routeSettings.name}');
    }
  }
}
