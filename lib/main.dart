import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'presentation/iu/ios/pages/root_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Platform.isAndroid ? const RootPage() : const RootPage(),
  );
}
