import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/strings/app_constraints.dart';

class BackupState extends ChangeNotifier {

  Future<void> exportBackupFile() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, AppConstraints.dbName);

    String formattedDate = DateTime.now().toString().replaceAll(':', '-');
    String newFileName = '${basenameWithoutExtension(dbPath)}_$formattedDate.db';

    final XFile dbFile = XFile(dbPath);
    await Share.shareXFiles([dbFile], text: 'Резервное копирование');
  }

  Future<String?> importBackupFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String? filePath = result.files.single.path;
      // Copy from filePath with check
    }
    return result!.files.single.path;
  }
}
