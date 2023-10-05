import 'package:dart_mappable/dart_mappable.dart';

class CustomDateTimeMapper extends DateTimeMapper {
  const CustomDateTimeMapper();

  @override
  String encode(DateTime self) {
    return self.toIso8601String();
  }
}