import 'package:flutter/material.dart';

import '../../../../core/routes/cupertino_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../ios/pages/home_page.dart';

class RootMaterialPage extends StatelessWidget {
  const RootMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: CupertinoRoutes.onGenerateRoute,
      home: HomePage(),
    );
  }
}
