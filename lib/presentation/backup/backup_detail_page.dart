import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/styles/app_styles.dart';
import '../../data/state/backup_state.dart';

class BackupDetailPage extends StatelessWidget {
  const BackupDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BackupState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocale.backup),
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Consumer<BackupState>(
            builder: (context, backupState, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    onTap: () async {

                    },
                    shape: AppStyles.shape,
                    title: Text(appLocale.import),
                    subtitle: Text(appLocale.selectImportFile),
                  ),
                  ListTile(
                    onTap: () async {

                    },
                    shape: AppStyles.shape,
                    title: Text(appLocale.export),
                    subtitle: Text(appLocale.selectExportPath),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
