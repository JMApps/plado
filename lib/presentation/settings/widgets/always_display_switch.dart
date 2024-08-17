import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../data/state/setting_data_state.dart';

class AlwaysDisplaySwitch extends StatelessWidget {
  const AlwaysDisplaySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingDataState>(
      builder: (context, settingDataState, _) {
        return ListTile(
          visualDensity: VisualDensity.compact,
          title: const Text(AppStrings.displayAlwaysOn),
          leading: const Icon(Icons.lightbulb_outline_rounded),
          trailing: Switch(
            value: settingDataState.getAlwaysOnDisplay,
            onChanged: (bool onChanged) {
              settingDataState.setAlwaysOnDisplay = onChanged;
            },
          ),
        );
      },
    );
  }
}
