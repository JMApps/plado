import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'data/services/plado_database_service.dart';
import 'presentation/iu/ios/pages/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = PladoDatabaseService();
  await databaseService.initializeDatabase();
  runApp(
    Platform.isAndroid ? const RootPage() : const RootPage(),
  );
}
