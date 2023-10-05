// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'initial_balance.dart';

class InitialBalanceMapper extends ClassMapperBase<InitialBalance> {
  InitialBalanceMapper._();

  static InitialBalanceMapper? _instance;
  static InitialBalanceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InitialBalanceMapper._());
      MapperContainer.globals.useAll([CustomDateTimeMapper()]);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'InitialBalance';

  static double _$balance(InitialBalance v) => v.balance;
  static const Field<InitialBalance, double> _f$balance =
      Field('balance', _$balance);
  static DateTime _$startDate(InitialBalance v) => v.startDate;
  static const Field<InitialBalance, DateTime> _f$startDate =
      Field('startDate', _$startDate);

  @override
  final Map<Symbol, Field<InitialBalance, dynamic>> fields = const {
    #balance: _f$balance,
    #startDate: _f$startDate,
  };

  static InitialBalance _instantiate(DecodingData data) {
    return InitialBalance(data.dec(_f$balance), data.dec(_f$startDate));
  }

  @override
  final Function instantiate = _instantiate;

  static InitialBalance fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<InitialBalance>(map));
  }

  static InitialBalance fromJson(String json) {
    return _guard((c) => c.fromJson<InitialBalance>(json));
  }
}

mixin InitialBalanceMappable {
  String toJson() {
    return InitialBalanceMapper._guard((c) => c.toJson(this as InitialBalance));
  }

  Map<String, dynamic> toMap() {
    return InitialBalanceMapper._guard((c) => c.toMap(this as InitialBalance));
  }

  InitialBalanceCopyWith<InitialBalance, InitialBalance, InitialBalance>
      get copyWith => _InitialBalanceCopyWithImpl(
          this as InitialBalance, $identity, $identity);
  @override
  String toString() {
    return InitialBalanceMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            InitialBalanceMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return InitialBalanceMapper._guard((c) => c.hash(this));
  }
}

extension InitialBalanceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InitialBalance, $Out> {
  InitialBalanceCopyWith<$R, InitialBalance, $Out> get $asInitialBalance =>
      $base.as((v, t, t2) => _InitialBalanceCopyWithImpl(v, t, t2));
}

abstract class InitialBalanceCopyWith<$R, $In extends InitialBalance, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? balance, DateTime? startDate});
  InitialBalanceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _InitialBalanceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InitialBalance, $Out>
    implements InitialBalanceCopyWith<$R, InitialBalance, $Out> {
  _InitialBalanceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InitialBalance> $mapper =
      InitialBalanceMapper.ensureInitialized();
  @override
  $R call({double? balance, DateTime? startDate}) => $apply(FieldCopyWithData({
        if (balance != null) #balance: balance,
        if (startDate != null) #startDate: startDate
      }));
  @override
  InitialBalance $make(CopyWithData data) => InitialBalance(
      data.get(#balance, or: $value.balance),
      data.get(#startDate, or: $value.startDate));

  @override
  InitialBalanceCopyWith<$R2, InitialBalance, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _InitialBalanceCopyWithImpl($value, $cast, t);
}
