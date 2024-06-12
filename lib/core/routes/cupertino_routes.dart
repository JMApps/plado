import 'package:flutter/cupertino.dart';

import '../../presentation/iu/ios/habit/pages/add_habit_page.dart';
import '../../presentation/iu/ios/habit/pages/update_habit_page.dart';
import '../../presentation/iu/ios/task/pages/add_task_page.dart';
import '../../presentation/iu/ios/task/pages/update_task_page.dart';
import '../strings/app_exception_messages.dart';
import 'name_routes.dart';

class CupertinoRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NameRoutes.createTaskPage:
        return CupertinoPageRoute(
          builder: (_) => const AddTaskPage(),
        );
      case NameRoutes.updateTaskPage:
        return CupertinoPageRoute(
          builder: (_) => const UpdateTaskPage(),
        );
      case NameRoutes.createHabitPage:
        return CupertinoPageRoute(
          builder: (_) => const AddHabitPage(),
        );
      case NameRoutes.updateHabitPage:
        return CupertinoPageRoute(
          builder: (_) => const UpdateHabitPage(),
        );
      default:
        throw Exception('${AppExceptionMessages.invalidRouteException} ${routeSettings.name}');
    }
  }
}
