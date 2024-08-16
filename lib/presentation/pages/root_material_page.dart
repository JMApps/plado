import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/material_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/themes/app_material_styles.dart';
import '../../data/state/setting_data_state.dart';
import 'home_page.dart';

class RootMaterialPage extends StatelessWidget {
  const RootMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingDataState = Provider.of<SettingDataState>(context);
    final AppMaterialStyles appMaterialStyles = AppMaterialStyles(themeColorIndex: settingDataState.getColorThemeIndex);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      locale: const Locale('ru'),
      theme: appMaterialStyles.lightTheme,
      darkTheme: appMaterialStyles.darkTheme,
      themeMode: settingDataState.getThemeMode,
      onGenerateRoute: MaterialRoutes.onGenerateRoute,
      home: const HomePage(),
    );
  }
}
