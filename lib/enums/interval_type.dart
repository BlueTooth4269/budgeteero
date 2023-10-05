import 'package:dart_mappable/dart_mappable.dart';

import 'enum_with_label.dart';

part 'interval_type.mapper.dart';

@MappableEnum()
enum IntervalType implements EnumWithLabel {
  daily('Daily'),
  weekly('Weekly'),
  monthly('Monthly'),
  yearly('Yearly');

  @override
  final String label;

  const IntervalType(this.label);
}