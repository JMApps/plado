import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/strings/app_constraints.dart';

class BackupState extends ChangeNotifier {
  Future<void> exportBackupFile() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, AppConstraints.dbName);

    String formattedDate = DateTime.now().toString()
        .replaceAll(':', '_')
        .replaceAll(' ', '_')
        .replaceAll('.', '_')
        .replaceAll('-', '_');

    String newFileName = 'plado_database_$formattedDate';

    Directory? appDir = await getExternalStorageDirectory();
    String tempFilePath = join(appDir!.path, '$newFileName.plado');

    await File(dbPath).copy(tempFilePath);

    final XFile dbFile = XFile(tempFilePath);
    await Share.shareXFiles([dbFile], text: 'Backup');

    await File(tempFilePath).delete();
  }

  Future<String?> importBackupFile() async {
    if (Platform.isAndroid) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String? filePath = result.files.single.path;

        Directory? externalDir = await getExternalStorageDirectory();

        if (externalDir != null) {
          String newFileName = AppConstraints.dbName;
          String tempFilePath = join(externalDir.path, newFileName);

          await File(filePath!).copy(tempFilePath);

          String databasesPath = await getDatabasesPath();
          String dbPath = join(databasesPath, AppConstraints.dbName);

          await File(tempFilePath).copy(dbPath);

          await File(tempFilePath).delete();

          return dbPath;
        }
      }
    }
    return null;
  }
}
