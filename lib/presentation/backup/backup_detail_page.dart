import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
                    onTap: backupState.getIsGranted ? () {} : null,
                    shape: AppStyles.shape,
                    title: const Text(AppStrings.import),
                    subtitle: const Text(AppStrings.selectImportFile),
                  ),
                  ListTile(
                    onTap: backupState.getIsGranted ? () {} : null,
                    shape: AppStyles.shape,
                    title: const Text(AppStrings.export),
                    subtitle: const Text(AppStrings.selectExportPath),
                  ),
                  backupState.getIsGranted ? const SizedBox() : !backupState.getIsDenied || !backupState.getIsPermanentlyDenied ? const Text(AppStrings.storagePermissionMessage) : const SizedBox(),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () async {
                      if (backupState.getIsPermanentlyDenied) {
                        openAppSettings();
                      } else if(backupState.getIsDenied) {
                        backupState.requestStoragePermission();
                      } else {
                        backupState.requestStoragePermission();
                      }
                    },
                    child: const Text(AppStrings.getPermission),
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
