import 'package:dart_mappable/dart_mappable.dart';

import '../enums/persistence_enums.dart';

part 'settings_persistence_model.mapper.dart';

@MappableClass()
class SettingsPersistenceModel with SettingsPersistenceModelMappable {
  final SaveMethod selectedSaveMethod;
  final SaveLocationOption selectedSaveLocationOption;
  final String? customSaveLocation;

  SettingsPersistenceModel(
      {SaveMethod? selectedSaveMethod,
      SaveLocationOption? selectedSaveLocationOption,
      this.customSaveLocation})
      : selectedSaveMethod = selectedSaveMethod ?? SaveMethod.auto,
        selectedSaveLocationOption =
            selectedSaveLocationOption ?? SaveLocationOption.defaultLocation;
}
