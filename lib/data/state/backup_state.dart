import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class BackupState extends ChangeNotifier {
  late PermissionStatus _status;

  BackupState() {
   _checkPermission();
  }

  _checkPermission() async {
    _status = await Permission.mediaLibrary.request();
    _storagePermission = true;
    _storageDenied = false;
    notifyListeners();
  }

  bool _storagePermission = false;
  bool _storageDenied = false;

  bool get getStoragePermission => _storagePermission;
  bool get getStorageDenied => _storageDenied;

  Future<void> requestStoragePermission() async {

    if (Platform.isAndroid) {
      if (await Permission.mediaLibrary.isGranted) {
        _storagePermission = true;
        _storageDenied = false;
      } else {
        _status = await Permission.mediaLibrary.request();
        if (_status.isGranted) {
          _storagePermission = true;
          _storageDenied = false;
        } else {
          _storagePermission = false;
          _storageDenied = _status.isDenied;
        }
      }
    } else {
      _status = await Permission.storage.request();
      if (_status.isGranted) {
        _storagePermission = true;
        _storageDenied = false;
      } else {
        _storagePermission = false;
        _storageDenied = _status.isDenied;
      }
    }

    notifyListeners();
  }
}
