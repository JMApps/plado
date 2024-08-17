import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/app_theme.dart';
import '../../../core/strings/app_strings.dart';
import '../../../data/state/setting_data_state.dart';

class AppThemeSegment extends StatelessWidget {
  const AppThemeSegment({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingDataState>(
      builder: (context, settingDataState, _) {
        return SegmentedButton(
          showSelectedIcon: true,
          segments: [
            ButtonSegment(
              value: AppTheme.light.index,
              label: const Text(AppStrings.lightTheme),
              tooltip: AppStrings.lightTheme,
            ),
            ButtonSegment(
              value: AppTheme.dark.index,
              label: const Text(AppStrings.darkTheme),
              tooltip: AppStrings.darkTheme,
            ),
            ButtonSegment(
              value: AppTheme.system.index,
              label: const Text(AppStrings.systemTheme),
              tooltip: AppStrings.systemTheme,
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
