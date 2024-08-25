import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/state/setting_data_state.dart';

class AlwaysDisplaySwitch extends StatelessWidget {
  const AlwaysDisplaySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<SettingDataState>(
      builder: (context, settingDataState, _) {
        return ListTile(
          visualDensity: VisualDensity.compact,
          title: Text(appLocale.displayAlwaysOn),
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
