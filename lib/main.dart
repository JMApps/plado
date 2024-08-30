import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'data/services/notifications/notification_service.dart';
import 'data/services/plado_database_service.dart';
import 'data/state/habit_data_state.dart';
import 'data/state/setting_data_state.dart';
import 'data/state/task_data_state.dart';
import 'presentation/pages/root_material_page.dart';
import 'presentation/state/bottom_nav_index_state.dart';
import 'presentation/state/habit/habit_sort_state.dart';
import 'presentation/state/rest_times_state.dart';
import 'presentation/state/task/task_sort_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PladoDatabaseService().initializeDatabase();
  await NotificationService().setupNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingDataState(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavIndexState(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestTimesState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskSortState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskDataState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitSortState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitDataState(),
        ),
      ],
      child: const RootMaterialPage(),
    ),
  );
}
