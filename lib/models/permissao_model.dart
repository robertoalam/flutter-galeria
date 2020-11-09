import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissaoModel {

  static getStatus() async {
    return await Permission.storage.request().isGranted;
  }
}
