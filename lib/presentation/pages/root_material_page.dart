import 'package:flutter/material.dart';
import 'package:plado/presentation/state/settings_state.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/material_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/themes/app_material_styles.dart';
import 'home_page.dart';

class RootMaterialPage extends StatelessWidget {
  const RootMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      locale: const Locale('ru'),
      theme: AppMaterialStyles.lightTheme,
      darkTheme: AppMaterialStyles.darkTheme,
      themeMode: Provider.of<SettingsState>(context).getThemeMode,
      onGenerateRoute: MaterialRoutes.onGenerateRoute,
      home: const HomePage(),
    );
  }
}
