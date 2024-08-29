import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/setting_data_state.dart';

class ColorThemeList extends StatelessWidget {
  const ColorThemeList({super.key});

  @override
  Widget build(BuildContext context) {
    final isThemeLight = Theme.of(context).brightness == Brightness.light ? true : false;
    return Consumer<SettingDataState>(
      builder: (context, settingDataState, _) {
        return GridView.builder(
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
                backgroundColor: AppStyles.taskHabitColors[index].withOpacity(isThemeLight ? 1 : 0.5),
                child: settingDataState.getColorThemeIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
              ),
            );
          },
        );
      },
    );
  }
}
