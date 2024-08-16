import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/app_theme.dart';
import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../data/state/setting_data_state.dart';
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
        child: Consumer<SettingDataState>(
          builder: (context, settingDataState, _) {
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
                  selected: {settingDataState.getThemeIndex},
                  onSelectionChanged: (newIndex) {
                    settingDataState.setThemeIndex = newIndex.first;
                  },
                ),
                const DescriptionText(text: 'Цвет темы'),
                const SizedBox(height: 8),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        settingDataState.setColorThemeIndex = index;
                      },
                      child: CircleAvatar(
                        backgroundColor: AppStyles.taskHabitColors[index].withOpacity(Theme.of(context).brightness == Brightness.light ? 1 : 0.5),
                        child: settingDataState.getColorThemeIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                const DescriptionText(text: 'Дисплей'),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  title: const Text('Дисплей всегда включен'),
                  leading: const Icon(Icons.lightbulb_outline_rounded),
                  trailing: Switch(
                    value: settingDataState.getAlwaysOnDisplay,
                    onChanged: (bool onChanged) {
                      settingDataState.setAlwaysOnDisplay = onChanged;
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
