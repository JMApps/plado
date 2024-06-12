import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'data/services/plado_database_service.dart';
import 'presentation/iu/android/pages/root_material_page.dart';
import 'presentation/iu/ios/pages/root_cupertino_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = PladoDatabaseService();
  await databaseService.initializeDatabase();
  runApp(
    Platform.isAndroid ? const RootMaterialPage() : const RootCupertinoPage(),
  );
}
