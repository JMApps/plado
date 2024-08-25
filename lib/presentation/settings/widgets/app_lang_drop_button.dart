import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/setting_data_state.dart';

class AppLangDropButton extends StatefulWidget {
  const AppLangDropButton({super.key});

  @override
  State<AppLangDropButton> createState() => _AppLangDropButtonState();
}

class _AppLangDropButtonState extends State<AppLangDropButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingDataState>(
      builder: (context, settingDataState, _) {
        return DropdownButton<String>(
          value: AppConstraints.appLanguages[settingDataState.getLocaleIndex],
          onChanged: (String? newValue) {
            if (newValue != null) {
              settingDataState.setLocaleIndex = AppConstraints.appLanguages.indexOf(newValue);
            }
          },
          items: AppConstraints.appLanguages.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }).toList(),
          icon: const Icon(Icons.language),
          padding: AppStyles.paddingHorizontal,
          borderRadius: AppStyles.border,
          alignment: AlignmentDirectional.center,
          underline: const SizedBox(),
          isExpanded: true,
        );
      },
    );
  }
}
