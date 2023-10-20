import 'package:dart_mappable/dart_mappable.dart';

part 'persistence_enums.mapper.dart';

@MappableEnum()
enum SaveMethod { auto, manual }

@MappableEnum()
enum SaveLocationOption { defaultLocation, customLocation }
