import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/material_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/themes/app_material_styles.dart';
import '../../data/state/habit_data_state.dart';
import '../../data/state/task_data_state.dart';
import '../state/bottom_nav_index_state.dart';
import '../state/habit_sort_state.dart';
import '../state/rest_times_state.dart';
import '../state/task_sort_state.dart';
import 'home_page.dart';

class RootMaterialPage extends StatelessWidget {
  const RootMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        locale: const Locale('ru'),
        theme: AppMaterialStyles.lightTheme,
        darkTheme: AppMaterialStyles.darkTheme,
        onGenerateRoute: MaterialRoutes.onGenerateRoute,
        home: const HomePage(),
      ),
    );
  }
}
