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
    try {
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, AppConstraints.dbName);

      if (!await File(dbPath).exists()) {
        throw Exception('Database file does not exist at $dbPath');
      }

      String formattedDate = DateTime.now()
          .toString()
          .replaceAll(':', '_')
          .replaceAll(' ', '_')
          .replaceAll('.', '_')
          .replaceAll('-', '_');

      String newFileName = 'plado_database_$formattedDate';

      Directory? appDir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      if (appDir == null) {
        throw Exception('Failed to get application directory.');
      }

      String tempFilePath = join(appDir.path, '$newFileName.plado');

      await File(dbPath).copy(tempFilePath);

      final XFile dbFile = XFile(tempFilePath);
      await Share.shareXFiles([dbFile]);

      await File(tempFilePath).delete();
    } catch (e) {
      debugPrint('Error during backup export: $e');
    }
  }

  Future<String?> importBackupFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String? filePath = result.files.single.path;

        if (filePath != null && filePath.endsWith('.plado')) {
          Directory? externalDir = Platform.isAndroid
              ? await getExternalStorageDirectory()
              : await getApplicationDocumentsDirectory();

          if (externalDir == null) {
            throw Exception('Failed to get external directory.');
          }

          String tempFilePath = join(externalDir.path, 'plado_database.plado');

          await File(filePath).copy(tempFilePath);

          String databasesPath = await getDatabasesPath();
          String dbPath = join(databasesPath, AppConstraints.dbName);

          await File(tempFilePath).copy(dbPath);
          await File(tempFilePath).delete();

          return dbPath;
        } else {
          throw Exception('Invalid file path or file type.');
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error during backup import: $e');
      return null;
    }
  }
}
