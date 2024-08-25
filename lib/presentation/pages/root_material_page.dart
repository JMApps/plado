import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plado/core/styles/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/material_routes.dart';
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      locale: AppStyles.appLocales[settingDataState.getLocaleIndex],
      theme: appMaterialStyles.lightTheme,
      darkTheme: appMaterialStyles.darkTheme,
      themeMode: settingDataState.getThemeMode,
      onGenerateRoute: MaterialRoutes.onGenerateRoute,
      home: const HomePage(),
    );
  }
}
