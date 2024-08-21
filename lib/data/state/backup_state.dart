import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupState extends ChangeNotifier {
  bool _isGranted = false;

  bool get getIsGranted => _isGranted;

  bool _isDenied = false;

  bool get getIsDenied => _isDenied;

  bool _isPermanentlyDenied = false;

  bool get getIsPermanentlyDenied => _isPermanentlyDenied;

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();

    switch (status) {
      case PermissionStatus.granted:
        _isGranted = true;
        _isDenied = false;
        _isPermanentlyDenied = false;
        break;
      case PermissionStatus.denied:
        _isGranted = false;
        _isDenied = true;
        _isPermanentlyDenied = false;
        break;
      case PermissionStatus.permanentlyDenied:
        _isGranted = false;
        _isDenied = false;
        _isPermanentlyDenied = true;
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
