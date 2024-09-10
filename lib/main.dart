import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'core/strings/app_constraints.dart';
import 'data/repositories/category_data_repository.dart';
import 'data/repositories/habit_data_repository.dart';
import 'data/repositories/task_data_repository.dart';
import 'data/services/notifications/notification_service.dart';
import 'data/services/plado_database_service.dart';
import 'domain/usecases/category_use_case.dart';
import 'domain/usecases/habit_use_case.dart';
import 'domain/usecases/task_use_case.dart';
import 'presentation/pages/root_material_page.dart';
import 'presentation/state/bottom_nav_index_state.dart';
import 'presentation/state/category/category_sort_state.dart';
import 'presentation/state/habit/habit_sort_state.dart';
import 'presentation/state/rest_times_state.dart';
import 'presentation/state/setting_data_state.dart';
import 'presentation/state/task/task_sort_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PladoDatabaseService pladoDatabaseService = PladoDatabaseService();
  await pladoDatabaseService.initializeDatabase();
  await NotificationService().setupNotification();
  await Hive.initFlutter();
  await Hive.openBox(AppConstraints.keyMainAppSettingsBox);

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
          create: (_) => TaskUseCase(TaskDataRepository(pladoDatabaseService)),
        ),
        ChangeNotifierProvider(
          create: (_) => CategorySortState(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryUseCase(CategoryDataRepository(pladoDatabaseService)),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitSortState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitUseCase(HabitDataRepository(pladoDatabaseService)),
        ),
      ],
      child: const RootMaterialPage(),
    ),
  );
}
