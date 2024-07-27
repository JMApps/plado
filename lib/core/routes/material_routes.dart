import 'package:flutter/material.dart';


import '../../data/models/arguments/create_task_args.dart';
import '../../data/models/arguments/habit_model_args.dart';
import '../../data/models/arguments/task_model_args.dart';
import '../../presentation/habit/pages/create_habit_page.dart';
import '../../presentation/habit/pages/habit_detail_page.dart';
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
        final TaskModelArgs taskModelArgs = routeSettings.arguments as TaskModelArgs;
        return MaterialPageRoute(
          builder: (_) => UpdateTaskPage(taskModel: taskModelArgs.taskEntity),
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
      default:
        throw Exception('${AppExceptionMessages.invalidRouteException} ${routeSettings.name}');
    }
  }
}
