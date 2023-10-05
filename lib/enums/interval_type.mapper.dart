// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'interval_type.dart';

class IntervalTypeMapper extends EnumMapper<IntervalType> {
  IntervalTypeMapper._();

  static IntervalTypeMapper? _instance;
  static IntervalTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntervalTypeMapper._());
    }
    return _instance!;
  }

  static IntervalType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  IntervalType decode(dynamic value) {
    switch (value) {
      case 'daily':
        return IntervalType.daily;
      case 'weekly':
        return IntervalType.weekly;
      case 'monthly':
        return IntervalType.monthly;
      case 'yearly':
        return IntervalType.yearly;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(IntervalType self) {
    switch (self) {
      case IntervalType.daily:
        return 'daily';
      case IntervalType.weekly:
        return 'weekly';
      case IntervalType.monthly:
        return 'monthly';
      case IntervalType.yearly:
        return 'yearly';
    }
  }
}

extension IntervalTypeMapperExtension on IntervalType {
  String toValue() {
    IntervalTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue(this) as String;
  }
}
