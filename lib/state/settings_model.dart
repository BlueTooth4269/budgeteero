import 'dart:io';

import 'package:budgeteero/enums/persistence_enums.dart';
import 'package:flutter/material.dart';

import '../models/settings_persistence_model.dart';
import '../util/io_service.dart';
import '../util/json_service.dart';

class SettingsModel extends ChangeNotifier {
  SaveMethod _selectedSaveMethod = SaveMethod.auto;
  SaveLocationOption _selectedSaveLocationOption =
      SaveLocationOption.defaultLocation;
  String? _customSaveLocation;
  bool _finishedLoadingFromFile = false;

  SettingsModel() {
    initialiseSettingsFromFile();
  }

  bool get finishedLoadingFromFile => _finishedLoadingFromFile;

  SaveMethod get selectedSaveMethod => _selectedSaveMethod;

  SaveLocationOption get selectedSaveLocationOption =>
      _selectedSaveLocationOption;

  String? get customSaveLocation => _customSaveLocation;

  Future<String> get currentSaveLocation async {
    return _selectedSaveLocationOption == SaveLocationOption.defaultLocation
        ? await IOService.defaultPath
        : _customSaveLocation!;
  }

  Future<void> setData(SaveMethod saveMethod, SaveLocationOption saveLocationOption,
      String? customSaveLocation) async {
    _selectedSaveMethod = saveMethod;
    await configureSaveLocation(saveLocationOption, customSaveLocation);
    notifyListeners();
  }

  Future<void> initialiseSettingsFromFile() async {
    String json = await IOService.readStringFromFilePath(
        '${await IOService.defaultPath}/settings.json');
    SettingsPersistenceModel settings =
        JsonService.readSettingsStateFromFile(json);
    _selectedSaveMethod = settings.selectedSaveMethod;
    await configureSaveLocation(
        settings.selectedSaveLocationOption, settings.customSaveLocation);
    _finishedLoadingFromFile = true;
    notifyListeners();
  }

  Future<void> writeSettingsStateToFile() async {
    String json = JsonService.writeSettingsStateToJsonString(
        _selectedSaveMethod, _selectedSaveLocationOption, _customSaveLocation);
    await IOService.writeStringToFilePath(
        json, '${await IOService.defaultPath}/settings.json');
  }

  Future<void> configureSaveLocation(SaveLocationOption saveLocationOption,
      [String? customSaveLocation]) async {
    if (saveLocationOption == SaveLocationOption.customLocation &&
        customSaveLocation == null) {
      return;
    }
    await safeCopyFileToNewLocation(saveLocationOption, customSaveLocation);
    if (saveLocationOption == SaveLocationOption.customLocation) {
      _customSaveLocation = customSaveLocation;
    }
    _selectedSaveLocationOption = saveLocationOption;
  }

  Future<void> safeCopyFileToNewLocation(
      SaveLocationOption saveLocationOption, String? customSaveLocation) async {
    if (saveLocationOption != _selectedSaveLocationOption ||
        (saveLocationOption == SaveLocationOption.customLocation &&
            customSaveLocation! != _customSaveLocation)) {
      String oldLocation =
          '${_selectedSaveLocationOption == SaveLocationOption.defaultLocation ? await IOService.defaultPath : _customSaveLocation!}/state.json';
      String newLocation =
          '${saveLocationOption == SaveLocationOption.defaultLocation ? await IOService.defaultPath : customSaveLocation!}/state.json';

      if (File(oldLocation).existsSync() && !File(newLocation).existsSync()) {
        File(oldLocation).copySync(newLocation);
      }
    }
  }
}
