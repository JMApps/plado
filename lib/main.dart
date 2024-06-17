import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'data/services/plado_database_service.dart';
import 'data/state/task_data_state.dart';
import 'presentation/pages/root_material_page.dart';
import 'presentation/state/bottom_nav_index_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = PladoDatabaseService();
  await databaseService.initializeDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BottomNavIndexState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskDataState(),
        ),
      ],
      child: const RootMaterialPage(),
    ),
  );
}
