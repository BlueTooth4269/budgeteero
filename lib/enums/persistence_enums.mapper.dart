// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'persistence_enums.dart';

class SaveMethodMapper extends EnumMapper<SaveMethod> {
  SaveMethodMapper._();

  static SaveMethodMapper? _instance;
  static SaveMethodMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SaveMethodMapper._());
    }
    return _instance!;
  }

  static SaveMethod fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SaveMethod decode(dynamic value) {
    switch (value) {
      case 'auto':
        return SaveMethod.auto;
      case 'manual':
        return SaveMethod.manual;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SaveMethod self) {
    switch (self) {
      case SaveMethod.auto:
        return 'auto';
      case SaveMethod.manual:
        return 'manual';
    }
  }
}

extension SaveMethodMapperExtension on SaveMethod {
  String toValue() {
    SaveMethodMapper.ensureInitialized();
    return MapperContainer.globals.toValue(this) as String;
  }
}

class SaveLocationOptionMapper extends EnumMapper<SaveLocationOption> {
  SaveLocationOptionMapper._();

  static SaveLocationOptionMapper? _instance;
  static SaveLocationOptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SaveLocationOptionMapper._());
    }
    return _instance!;
  }

  static SaveLocationOption fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SaveLocationOption decode(dynamic value) {
    switch (value) {
      case 'defaultLocation':
        return SaveLocationOption.defaultLocation;
      case 'customLocation':
        return SaveLocationOption.customLocation;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SaveLocationOption self) {
    switch (self) {
      case SaveLocationOption.defaultLocation:
        return 'defaultLocation';
      case SaveLocationOption.customLocation:
        return 'customLocation';
    }
  }
}

extension SaveLocationOptionMapperExtension on SaveLocationOption {
  String toValue() {
    SaveLocationOptionMapper.ensureInitialized();
    return MapperContainer.globals.toValue(this) as String;
  }
}
