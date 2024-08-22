import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:plado/core/strings/app_constraints.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../data/state/backup_state.dart';

class BackupDetailPage extends StatelessWidget {
  const BackupDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BackupState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.backup),
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
                      String databasesPath = await getDatabasesPath();
                      String dbPath = join(databasesPath, AppConstraints.dbName);

                      String formattedDate = DateTime.now().toString().replaceAll(':', '-');
                      String newFileName = '${basenameWithoutExtension(dbPath)}_$formattedDate.db';
                      
                      final XFile dbFile = XFile(dbPath);
                      await Share.shareXFiles([dbFile], text: 'Резервное копирование');
                    },
                    shape: AppStyles.shape,
                    title: const Text(AppStrings.import),
                    subtitle: const Text(AppStrings.selectImportFile),
                  ),
                  ListTile(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        String? filePath = result.files.single.path;
                        // Copy from filePath with check
                      }
                    },
                    shape: AppStyles.shape,
                    title: const Text(AppStrings.export),
                    subtitle: const Text(AppStrings.selectExportPath),
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
