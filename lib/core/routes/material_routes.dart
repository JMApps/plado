import 'package:flutter/material.dart';

import '../../presentation/iu/android/habit/pages/add_habit_page.dart';
import '../../presentation/iu/android/habit/pages/update_habit_page.dart';
import '../../presentation/iu/android/task/pages/add_task_page.dart';
import '../../presentation/iu/android/task/pages/update_task_page.dart';
import '../strings/app_exception_messages.dart';
import 'name_routes.dart';

class MaterialRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NameRoutes.createTaskPage:
        return MaterialPageRoute(
          builder: (_) => const AddTaskPage(),
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