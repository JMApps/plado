import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskTimerPage extends StatelessWidget {
  const TaskTimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.taskTimer),
      ),
      body: Container(),
    );
  }
}
