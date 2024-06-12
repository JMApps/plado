import 'package:flutter/cupertino.dart';

import '../../../../core/routes/cupertino_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/themes/app_cupertino_styles.dart';
import 'home_page.dart';

class RootCupertinoPage extends StatelessWidget {
  const RootCupertinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: CupertinoRoutes.onGenerateRoute,
      theme: AppCupertinoStyles.lightTheme,
      home: const HomePage(),
    );
  }
}
