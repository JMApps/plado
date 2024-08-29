import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/app_theme.dart';
import '../../state/setting_data_state.dart';

class AppThemeSegment extends StatelessWidget {
  const AppThemeSegment({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<SettingDataState>(
      builder: (context, settingDataState, _) {
        return SegmentedButton(
          showSelectedIcon: true,
          segments: [
            ButtonSegment(
              value: AppTheme.light.index,
              label: Text(
                appLocale.lightTheme,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.lightTheme,
            ),
            ButtonSegment(
              value: AppTheme.dark.index,
              label: Text(
                appLocale.darkTheme,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.darkTheme,
            ),
            ButtonSegment(
              value: AppTheme.system.index,
              label: Text(
                appLocale.systemTheme,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.systemTheme,
            ),
          ],
          selected: {settingDataState.getThemeIndex},
          onSelectionChanged: (newIndex) {
            settingDataState.setThemeIndex = newIndex.first;
          },
        );
      },
    );
  }
}
