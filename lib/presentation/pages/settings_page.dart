import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/app_theme.dart';
import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../state/settings_state.dart';
import '../widgets/description_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: SingleChildScrollView(
        padding: AppStyles.paddingMini,
        child: Consumer<SettingsState>(
          builder: (context, settingsPage, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DescriptionText(text: 'Тема'),
                SegmentedButton(
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
                  selected: {settingsPage.getThemeIndex},
                  onSelectionChanged: (newIndex) {
                    settingsPage.setThemeIndex = newIndex.first;
                  },
                ),
                const SizedBox(height: 8),
                const DescriptionText(text: 'Дисплей'),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  title: const Text('Дисплей всегда включен'),
                  leading: const Icon(Icons.lightbulb_outline_rounded),
                  trailing: Switch(
                    value: settingsPage.getAlwaysOnDisplay,
                    onChanged: (bool onChanged) {
                      settingsPage.setAlwaysOnDisplay = onChanged;
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
