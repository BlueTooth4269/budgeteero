import 'dart:io';

import 'package:path_provider/path_provider.dart';

class IOService {
  static Future<String> get defaultPath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/Budgeteero';
  }

  static Future<void> writeStringToFilePath(
      String string, String filePath) async {
    File file = File(filePath);
    await file.writeAsString(string, flush: true, mode: FileMode.writeOnly);
  }

  static Future<String> readStringFromFilePath(String filePath) async {
    try {
      File file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }
}
