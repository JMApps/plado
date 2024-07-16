import 'package:flutter/cupertino.dart';

import 'data/services/notifications/notification_service.dart';
import 'presentation/pages/root_material_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().setupNotification();
  runApp(
    const RootMaterialPage(),
  );
}
