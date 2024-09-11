import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../core/styles/app_styles.dart';
import '../../data/state/backup_state.dart';
import '../widgets/text_description_bold.dart';

class BackupDetailPage extends StatefulWidget {
  const BackupDetailPage({super.key});

  @override
  State<BackupDetailPage> createState() => _BackupDetailPageState();
}

class _BackupDetailPageState extends State<BackupDetailPage> {
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
                  TextDescriptionBold(text: appLocale.backupWarning),
                  ListTile(
                    onTap: () async {
                      await backupState.importBackupFile();
                    },
                    shape: AppStyles.shape,
                    title: Text(appLocale.import),
                    subtitle: Text(appLocale.selectImportFile),
                  ),
                  ListTile(
                    onTap: () async {
                      await backupState.exportBackupFile();
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
