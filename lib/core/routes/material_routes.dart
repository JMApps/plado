import 'package:flutter/material.dart';

import '../../data/models/arguments/create_task_args.dart';
import '../../data/models/arguments/update_habit_args.dart';
import '../../data/models/arguments/update_task_args.dart';
import '../../presentation/habit/pages/create_habit_page.dart';
import '../../presentation/habit/pages/update_habit_page.dart';
import '../../presentation/task/pages/create_task_page.dart';
import '../../presentation/task/pages/update_task_page.dart';
import '../strings/app_exception_messages.dart';
import 'name_routes.dart';

class MaterialRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NameRoutes.createTaskPage:
        final CreateTaskArgs createTaskArgs = routeSettings.arguments as CreateTaskArgs;
        return MaterialPageRoute(
          builder: (_) => CreateTaskPage(taskPeriodIndex: createTaskArgs.taskPeriodIndex),
        );
      case NameRoutes.updateTaskPage:
        final UpdateTaskArgs updateTaskArgs = routeSettings.arguments as UpdateTaskArgs;
        return MaterialPageRoute(
          builder: (_) => UpdateTaskPage(taskModel: updateTaskArgs.taskEntity),
        );
      case NameRoutes.createHabitPage:
        return MaterialPageRoute(
          builder: (_) => const CreateHabitPage(),
        );
      case NameRoutes.updateHabitPage:
        final UpdateHabitArgs updateHabitArgs = routeSettings.arguments as UpdateHabitArgs;
        return MaterialPageRoute(
          builder: (_) => UpdateHabitPage(habitModel: updateHabitArgs.habitEntity),
        );
      default:
        throw Exception('${AppExceptionMessages.invalidRouteException} ${routeSettings.name}');
    }
  }
}
