// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'settings_persistence_model.dart';

class SettingsPersistenceModelMapper
    extends ClassMapperBase<SettingsPersistenceModel> {
  SettingsPersistenceModelMapper._();

  static SettingsPersistenceModelMapper? _instance;
  static SettingsPersistenceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = SettingsPersistenceModelMapper._());
      SaveMethodMapper.ensureInitialized();
      SaveLocationOptionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'SettingsPersistenceModel';

  static SaveMethod _$selectedSaveMethod(SettingsPersistenceModel v) =>
      v.selectedSaveMethod;
  static const Field<SettingsPersistenceModel, SaveMethod>
      _f$selectedSaveMethod =
      Field('selectedSaveMethod', _$selectedSaveMethod, opt: true);
  static SaveLocationOption _$selectedSaveLocationOption(
          SettingsPersistenceModel v) =>
      v.selectedSaveLocationOption;
  static const Field<SettingsPersistenceModel, SaveLocationOption>
      _f$selectedSaveLocationOption = Field(
          'selectedSaveLocationOption', _$selectedSaveLocationOption,
          opt: true);
  static String? _$customSaveLocation(SettingsPersistenceModel v) =>
      v.customSaveLocation;
  static const Field<SettingsPersistenceModel, String> _f$customSaveLocation =
      Field('customSaveLocation', _$customSaveLocation, opt: true);

  @override
  final Map<Symbol, Field<SettingsPersistenceModel, dynamic>> fields = const {
    #selectedSaveMethod: _f$selectedSaveMethod,
    #selectedSaveLocationOption: _f$selectedSaveLocationOption,
    #customSaveLocation: _f$customSaveLocation,
  };

  static SettingsPersistenceModel _instantiate(DecodingData data) {
    return SettingsPersistenceModel(
        selectedSaveMethod: data.dec(_f$selectedSaveMethod),
        selectedSaveLocationOption: data.dec(_f$selectedSaveLocationOption),
        customSaveLocation: data.dec(_f$customSaveLocation));
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsPersistenceModel fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<SettingsPersistenceModel>(map));
  }

  static SettingsPersistenceModel fromJson(String json) {
    return _guard((c) => c.fromJson<SettingsPersistenceModel>(json));
  }
}

mixin SettingsPersistenceModelMappable {
  String toJson() {
    return SettingsPersistenceModelMapper._guard(
        (c) => c.toJson(this as SettingsPersistenceModel));
  }

  Map<String, dynamic> toMap() {
    return SettingsPersistenceModelMapper._guard(
        (c) => c.toMap(this as SettingsPersistenceModel));
  }

  SettingsPersistenceModelCopyWith<SettingsPersistenceModel,
          SettingsPersistenceModel, SettingsPersistenceModel>
      get copyWith => _SettingsPersistenceModelCopyWithImpl(
          this as SettingsPersistenceModel, $identity, $identity);
  @override
  String toString() {
    return SettingsPersistenceModelMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SettingsPersistenceModelMapper._guard(
                (c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return SettingsPersistenceModelMapper._guard((c) => c.hash(this));
  }
}

extension SettingsPersistenceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsPersistenceModel, $Out> {
  SettingsPersistenceModelCopyWith<$R, SettingsPersistenceModel, $Out>
      get $asSettingsPersistenceModel => $base
          .as((v, t, t2) => _SettingsPersistenceModelCopyWithImpl(v, t, t2));
}

abstract class SettingsPersistenceModelCopyWith<
    $R,
    $In extends SettingsPersistenceModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {SaveMethod? selectedSaveMethod,
      SaveLocationOption? selectedSaveLocationOption,
      String? customSaveLocation});
  SettingsPersistenceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SettingsPersistenceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsPersistenceModel, $Out>
    implements
        SettingsPersistenceModelCopyWith<$R, SettingsPersistenceModel, $Out> {
  _SettingsPersistenceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsPersistenceModel> $mapper =
      SettingsPersistenceModelMapper.ensureInitialized();
  @override
  $R call(
          {Object? selectedSaveMethod = $none,
          Object? selectedSaveLocationOption = $none,
          Object? customSaveLocation = $none}) =>
      $apply(FieldCopyWithData({
        if (selectedSaveMethod != $none)
          #selectedSaveMethod: selectedSaveMethod,
        if (selectedSaveLocationOption != $none)
          #selectedSaveLocationOption: selectedSaveLocationOption,
        if (customSaveLocation != $none) #customSaveLocation: customSaveLocation
      }));
  @override
  SettingsPersistenceModel $make(CopyWithData data) => SettingsPersistenceModel(
      selectedSaveMethod:
          data.get(#selectedSaveMethod, or: $value.selectedSaveMethod),
      selectedSaveLocationOption: data.get(#selectedSaveLocationOption,
          or: $value.selectedSaveLocationOption),
      customSaveLocation:
          data.get(#customSaveLocation, or: $value.customSaveLocation));

  @override
  SettingsPersistenceModelCopyWith<$R2, SettingsPersistenceModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SettingsPersistenceModelCopyWithImpl($value, $cast, t);
}
