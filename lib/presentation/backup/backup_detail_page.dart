import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
                    onTap: backupState.getStoragePermission ? () {
                    } : null,
                    shape: AppStyles.shape,
                    title: const Text(AppStrings.import),
                    subtitle: const Text(AppStrings.selectImportFile),
                  ),
                  ListTile(
                    onTap: backupState.getStoragePermission ? () {
                    } : null,
                    shape: AppStyles.shape,
                    title: const Text(AppStrings.export),
                    subtitle: const Text(AppStrings.selectExportPath),
                  ),
                  const SizedBox(height: 16),
                  backupState.getStorageDenied
                      ? const Text(AppStrings.storagePermissionMessageDenied)
                      : !backupState.getStoragePermission
                      ? const Text(AppStrings.storagePermissionMessage)
                      : const SizedBox(),
                  !backupState.getStoragePermission ? const SizedBox(height: 16) : const SizedBox(),
                  !backupState.getStoragePermission
                      ? OutlinedButton(
                    onPressed: () async {
                      if (backupState.getStorageDenied) {
                        openAppSettings();
                      } else {
                        await backupState.requestStoragePermission();
                      }
                    },
                    child: const Text(AppStrings.getPermission),
                  ) : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
