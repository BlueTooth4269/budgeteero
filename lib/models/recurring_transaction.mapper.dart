// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'recurring_transaction.dart';

class RecurringTransactionMapper extends ClassMapperBase<RecurringTransaction> {
  RecurringTransactionMapper._();

  static RecurringTransactionMapper? _instance;
  static RecurringTransactionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RecurringTransactionMapper._());
      MapperContainer.globals.useAll([CustomDateTimeMapper()]);
      RepetitionLimitedRecurringTransactionMapper.ensureInitialized();
      EndDateLimitedRecurringTransactionMapper.ensureInitialized();
      IntervalTypeMapper.ensureInitialized();
      TransactionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'RecurringTransaction';

  static String _$id(RecurringTransaction v) => v.id;
  static const Field<RecurringTransaction, String> _f$id = Field('id', _$id);
  static DateTime _$startDate(RecurringTransaction v) => v.startDate;
  static const Field<RecurringTransaction, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static double _$amount(RecurringTransaction v) => v.amount;
  static const Field<RecurringTransaction, double> _f$amount =
      Field('amount', _$amount);
  static IntervalType _$intervalType(RecurringTransaction v) => v.intervalType;
  static const Field<RecurringTransaction, IntervalType> _f$intervalType =
      Field('intervalType', _$intervalType);
  static String _$description(RecurringTransaction v) => v.description;
  static const Field<RecurringTransaction, String> _f$description =
      Field('description', _$description);
  static String _$transactionPartner(RecurringTransaction v) =>
      v.transactionPartner;
  static const Field<RecurringTransaction, String> _f$transactionPartner =
      Field('transactionPartner', _$transactionPartner);
  static List<Transaction> _$transactions(RecurringTransaction v) =>
      v.transactions;
  static const Field<RecurringTransaction, List<Transaction>> _f$transactions =
      Field('transactions', _$transactions);
  static Uuid _$uuid(RecurringTransaction v) => v.uuid;
  static const Field<RecurringTransaction, Uuid> _f$uuid =
      Field('uuid', _$uuid, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<RecurringTransaction, dynamic>> fields = const {
    #id: _f$id,
    #startDate: _f$startDate,
    #amount: _f$amount,
    #intervalType: _f$intervalType,
    #description: _f$description,
    #transactionPartner: _f$transactionPartner,
    #transactions: _f$transactions,
    #uuid: _f$uuid,
  };

  @override
  final MappingHook hook = const UnmappedPropertiesHook('uuid');
  static RecurringTransaction _instantiate(DecodingData data) {
    return RecurringTransaction(
        id: data.dec(_f$id),
        startDate: data.dec(_f$startDate),
        amount: data.dec(_f$amount),
        intervalType: data.dec(_f$intervalType),
        description: data.dec(_f$description),
        transactionPartner: data.dec(_f$transactionPartner),
        transactions: data.dec(_f$transactions));
  }

  @override
  final Function instantiate = _instantiate;

  static RecurringTransaction fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<RecurringTransaction>(map));
  }

  static RecurringTransaction fromJson(String json) {
    return _guard((c) => c.fromJson<RecurringTransaction>(json));
  }
}

mixin RecurringTransactionMappable {
  String toJson() {
    return RecurringTransactionMapper._guard(
        (c) => c.toJson(this as RecurringTransaction));
  }

  Map<String, dynamic> toMap() {
    return RecurringTransactionMapper._guard(
        (c) => c.toMap(this as RecurringTransaction));
  }

  RecurringTransactionCopyWith<RecurringTransaction, RecurringTransaction,
          RecurringTransaction>
      get copyWith => _RecurringTransactionCopyWithImpl(
          this as RecurringTransaction, $identity, $identity);
  @override
  String toString() {
    return RecurringTransactionMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RecurringTransactionMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return RecurringTransactionMapper._guard((c) => c.hash(this));
  }
}

extension RecurringTransactionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RecurringTransaction, $Out> {
  RecurringTransactionCopyWith<$R, RecurringTransaction, $Out>
      get $asRecurringTransaction =>
          $base.as((v, t, t2) => _RecurringTransactionCopyWithImpl(v, t, t2));
}

abstract class RecurringTransactionCopyWith<
    $R,
    $In extends RecurringTransaction,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Transaction,
      TransactionCopyWith<$R, Transaction, Transaction>> get transactions;
  $R call(
      {String? id,
      DateTime? startDate,
      double? amount,
      IntervalType? intervalType,
      String? description,
      String? transactionPartner,
      List<Transaction>? transactions});
  RecurringTransactionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RecurringTransactionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RecurringTransaction, $Out>
    implements RecurringTransactionCopyWith<$R, RecurringTransaction, $Out> {
  _RecurringTransactionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RecurringTransaction> $mapper =
      RecurringTransactionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Transaction,
          TransactionCopyWith<$R, Transaction, Transaction>>
      get transactions => ListCopyWith($value.transactions,
          (v, t) => v.copyWith.$chain(t), (v) => call(transactions: v));
  @override
  $R call(
          {String? id,
          DateTime? startDate,
          double? amount,
          IntervalType? intervalType,
          String? description,
          String? transactionPartner,
          List<Transaction>? transactions}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (startDate != null) #startDate: startDate,
        if (amount != null) #amount: amount,
        if (intervalType != null) #intervalType: intervalType,
        if (description != null) #description: description,
        if (transactionPartner != null) #transactionPartner: transactionPartner,
        if (transactions != null) #transactions: transactions
      }));
  @override
  RecurringTransaction $make(CopyWithData data) => RecurringTransaction(
      id: data.get(#id, or: $value.id),
      startDate: data.get(#startDate, or: $value.startDate),
      amount: data.get(#amount, or: $value.amount),
      intervalType: data.get(#intervalType, or: $value.intervalType),
      description: data.get(#description, or: $value.description),
      transactionPartner:
          data.get(#transactionPartner, or: $value.transactionPartner),
      transactions: data.get(#transactions, or: $value.transactions));

  @override
  RecurringTransactionCopyWith<$R2, RecurringTransaction, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _RecurringTransactionCopyWithImpl($value, $cast, t);
}

class RepetitionLimitedRecurringTransactionMapper
    extends SubClassMapperBase<RepetitionLimitedRecurringTransaction> {
  RepetitionLimitedRecurringTransactionMapper._();

  static RepetitionLimitedRecurringTransactionMapper? _instance;
  static RepetitionLimitedRecurringTransactionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = RepetitionLimitedRecurringTransactionMapper._());
      RecurringTransactionMapper.ensureInitialized().addSubMapper(_instance!);
      IntervalTypeMapper.ensureInitialized();
      TransactionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'RepetitionLimitedRecurringTransaction';

  static String _$id(RepetitionLimitedRecurringTransaction v) => v.id;
  static const Field<RepetitionLimitedRecurringTransaction, String> _f$id =
      Field('id', _$id);
  static DateTime _$startDate(RepetitionLimitedRecurringTransaction v) =>
      v.startDate;
  static const Field<RepetitionLimitedRecurringTransaction, DateTime>
      _f$startDate = Field('startDate', _$startDate);
  static double _$amount(RepetitionLimitedRecurringTransaction v) => v.amount;
  static const Field<RepetitionLimitedRecurringTransaction, double> _f$amount =
      Field('amount', _$amount);
  static IntervalType _$intervalType(RepetitionLimitedRecurringTransaction v) =>
      v.intervalType;
  static const Field<RepetitionLimitedRecurringTransaction, IntervalType>
      _f$intervalType = Field('intervalType', _$intervalType);
  static String _$description(RepetitionLimitedRecurringTransaction v) =>
      v.description;
  static const Field<RepetitionLimitedRecurringTransaction, String>
      _f$description = Field('description', _$description);
  static String _$transactionPartner(RepetitionLimitedRecurringTransaction v) =>
      v.transactionPartner;
  static const Field<RepetitionLimitedRecurringTransaction, String>
      _f$transactionPartner = Field('transactionPartner', _$transactionPartner);
  static List<Transaction> _$transactions(
          RepetitionLimitedRecurringTransaction v) =>
      v.transactions;
  static const Field<RepetitionLimitedRecurringTransaction, List<Transaction>>
      _f$transactions = Field('transactions', _$transactions);
  static int _$repetitions(RepetitionLimitedRecurringTransaction v) =>
      v.repetitions;
  static const Field<RepetitionLimitedRecurringTransaction, int>
      _f$repetitions = Field('repetitions', _$repetitions);
  static Uuid _$uuid(RepetitionLimitedRecurringTransaction v) => v.uuid;
  static const Field<RepetitionLimitedRecurringTransaction, Uuid> _f$uuid =
      Field('uuid', _$uuid, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<RepetitionLimitedRecurringTransaction, dynamic>>
      fields = const {
    #id: _f$id,
    #startDate: _f$startDate,
    #amount: _f$amount,
    #intervalType: _f$intervalType,
    #description: _f$description,
    #transactionPartner: _f$transactionPartner,
    #transactions: _f$transactions,
    #repetitions: _f$repetitions,
    #uuid: _f$uuid,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'RepetitionLimitedRecurringTransaction';
  @override
  late final ClassMapperBase superMapper =
      RecurringTransactionMapper.ensureInitialized();

  @override
  final MappingHook superHook = const UnmappedPropertiesHook('uuid');

  static RepetitionLimitedRecurringTransaction _instantiate(DecodingData data) {
    return RepetitionLimitedRecurringTransaction(
        id: data.dec(_f$id),
        startDate: data.dec(_f$startDate),
        amount: data.dec(_f$amount),
        intervalType: data.dec(_f$intervalType),
        description: data.dec(_f$description),
        transactionPartner: data.dec(_f$transactionPartner),
        transactions: data.dec(_f$transactions),
        repetitions: data.dec(_f$repetitions));
  }

  @override
  final Function instantiate = _instantiate;

  static RepetitionLimitedRecurringTransaction fromMap(
      Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<RepetitionLimitedRecurringTransaction>(map));
  }

  static RepetitionLimitedRecurringTransaction fromJson(String json) {
    return _guard(
        (c) => c.fromJson<RepetitionLimitedRecurringTransaction>(json));
  }
}

mixin RepetitionLimitedRecurringTransactionMappable {
  String toJson() {
    return RepetitionLimitedRecurringTransactionMapper._guard(
        (c) => c.toJson(this as RepetitionLimitedRecurringTransaction));
  }

  Map<String, dynamic> toMap() {
    return RepetitionLimitedRecurringTransactionMapper._guard(
        (c) => c.toMap(this as RepetitionLimitedRecurringTransaction));
  }

  RepetitionLimitedRecurringTransactionCopyWith<
          RepetitionLimitedRecurringTransaction,
          RepetitionLimitedRecurringTransaction,
          RepetitionLimitedRecurringTransaction>
      get copyWith => _RepetitionLimitedRecurringTransactionCopyWithImpl(
          this as RepetitionLimitedRecurringTransaction, $identity, $identity);
  @override
  String toString() {
    return RepetitionLimitedRecurringTransactionMapper._guard(
        (c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RepetitionLimitedRecurringTransactionMapper._guard(
                (c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return RepetitionLimitedRecurringTransactionMapper._guard(
        (c) => c.hash(this));
  }
}

extension RepetitionLimitedRecurringTransactionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RepetitionLimitedRecurringTransaction, $Out> {
  RepetitionLimitedRecurringTransactionCopyWith<$R,
          RepetitionLimitedRecurringTransaction, $Out>
      get $asRepetitionLimitedRecurringTransaction => $base.as((v, t, t2) =>
          _RepetitionLimitedRecurringTransactionCopyWithImpl(v, t, t2));
}

abstract class RepetitionLimitedRecurringTransactionCopyWith<
    $R,
    $In extends RepetitionLimitedRecurringTransaction,
    $Out> implements RecurringTransactionCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<$R, Transaction,
      TransactionCopyWith<$R, Transaction, Transaction>> get transactions;
  @override
  $R call(
      {String? id,
      DateTime? startDate,
      double? amount,
      IntervalType? intervalType,
      String? description,
      String? transactionPartner,
      List<Transaction>? transactions,
      int? repetitions});
  RepetitionLimitedRecurringTransactionCopyWith<$R2, $In, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RepetitionLimitedRecurringTransactionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RepetitionLimitedRecurringTransaction, $Out>
    implements
        RepetitionLimitedRecurringTransactionCopyWith<$R,
            RepetitionLimitedRecurringTransaction, $Out> {
  _RepetitionLimitedRecurringTransactionCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RepetitionLimitedRecurringTransaction> $mapper =
      RepetitionLimitedRecurringTransactionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Transaction,
          TransactionCopyWith<$R, Transaction, Transaction>>
      get transactions => ListCopyWith($value.transactions,
          (v, t) => v.copyWith.$chain(t), (v) => call(transactions: v));
  @override
  $R call(
          {String? id,
          DateTime? startDate,
          double? amount,
          IntervalType? intervalType,
          String? description,
          String? transactionPartner,
          List<Transaction>? transactions,
          int? repetitions}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (startDate != null) #startDate: startDate,
        if (amount != null) #amount: amount,
        if (intervalType != null) #intervalType: intervalType,
        if (description != null) #description: description,
        if (transactionPartner != null) #transactionPartner: transactionPartner,
        if (transactions != null) #transactions: transactions,
        if (repetitions != null) #repetitions: repetitions
      }));
  @override
  RepetitionLimitedRecurringTransaction $make(CopyWithData data) =>
      RepetitionLimitedRecurringTransaction(
          id: data.get(#id, or: $value.id),
          startDate: data.get(#startDate, or: $value.startDate),
          amount: data.get(#amount, or: $value.amount),
          intervalType: data.get(#intervalType, or: $value.intervalType),
          description: data.get(#description, or: $value.description),
          transactionPartner:
              data.get(#transactionPartner, or: $value.transactionPartner),
          transactions: data.get(#transactions, or: $value.transactions),
          repetitions: data.get(#repetitions, or: $value.repetitions));

  @override
  RepetitionLimitedRecurringTransactionCopyWith<$R2,
      RepetitionLimitedRecurringTransaction, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RepetitionLimitedRecurringTransactionCopyWithImpl($value, $cast, t);
}

class EndDateLimitedRecurringTransactionMapper
    extends SubClassMapperBase<EndDateLimitedRecurringTransaction> {
  EndDateLimitedRecurringTransactionMapper._();

  static EndDateLimitedRecurringTransactionMapper? _instance;
  static EndDateLimitedRecurringTransactionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = EndDateLimitedRecurringTransactionMapper._());
      RecurringTransactionMapper.ensureInitialized().addSubMapper(_instance!);
      IntervalTypeMapper.ensureInitialized();
      TransactionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'EndDateLimitedRecurringTransaction';

  static String _$id(EndDateLimitedRecurringTransaction v) => v.id;
  static const Field<EndDateLimitedRecurringTransaction, String> _f$id =
      Field('id', _$id);
  static DateTime _$startDate(EndDateLimitedRecurringTransaction v) =>
      v.startDate;
  static const Field<EndDateLimitedRecurringTransaction, DateTime>
      _f$startDate = Field('startDate', _$startDate);
  static double _$amount(EndDateLimitedRecurringTransaction v) => v.amount;
  static const Field<EndDateLimitedRecurringTransaction, double> _f$amount =
      Field('amount', _$amount);
  static IntervalType _$intervalType(EndDateLimitedRecurringTransaction v) =>
      v.intervalType;
  static const Field<EndDateLimitedRecurringTransaction, IntervalType>
      _f$intervalType = Field('intervalType', _$intervalType);
  static String _$description(EndDateLimitedRecurringTransaction v) =>
      v.description;
  static const Field<EndDateLimitedRecurringTransaction, String>
      _f$description = Field('description', _$description);
  static String _$transactionPartner(EndDateLimitedRecurringTransaction v) =>
      v.transactionPartner;
  static const Field<EndDateLimitedRecurringTransaction, String>
      _f$transactionPartner = Field('transactionPartner', _$transactionPartner);
  static List<Transaction> _$transactions(
          EndDateLimitedRecurringTransaction v) =>
      v.transactions;
  static const Field<EndDateLimitedRecurringTransaction, List<Transaction>>
      _f$transactions = Field('transactions', _$transactions);
  static DateTime _$endDate(EndDateLimitedRecurringTransaction v) => v.endDate;
  static const Field<EndDateLimitedRecurringTransaction, DateTime> _f$endDate =
      Field('endDate', _$endDate);
  static Uuid _$uuid(EndDateLimitedRecurringTransaction v) => v.uuid;
  static const Field<EndDateLimitedRecurringTransaction, Uuid> _f$uuid =
      Field('uuid', _$uuid, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<EndDateLimitedRecurringTransaction, dynamic>> fields =
      const {
    #id: _f$id,
    #startDate: _f$startDate,
    #amount: _f$amount,
    #intervalType: _f$intervalType,
    #description: _f$description,
    #transactionPartner: _f$transactionPartner,
    #transactions: _f$transactions,
    #endDate: _f$endDate,
    #uuid: _f$uuid,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'EndDateLimitedRecurringTransaction';
  @override
  late final ClassMapperBase superMapper =
      RecurringTransactionMapper.ensureInitialized();

  @override
  final MappingHook superHook = const UnmappedPropertiesHook('uuid');

  static EndDateLimitedRecurringTransaction _instantiate(DecodingData data) {
    return EndDateLimitedRecurringTransaction(
        id: data.dec(_f$id),
        startDate: data.dec(_f$startDate),
        amount: data.dec(_f$amount),
        intervalType: data.dec(_f$intervalType),
        description: data.dec(_f$description),
        transactionPartner: data.dec(_f$transactionPartner),
        transactions: data.dec(_f$transactions),
        endDate: data.dec(_f$endDate));
  }

  @override
  final Function instantiate = _instantiate;

  static EndDateLimitedRecurringTransaction fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<EndDateLimitedRecurringTransaction>(map));
  }

  static EndDateLimitedRecurringTransaction fromJson(String json) {
    return _guard((c) => c.fromJson<EndDateLimitedRecurringTransaction>(json));
  }
}

mixin EndDateLimitedRecurringTransactionMappable {
  String toJson() {
    return EndDateLimitedRecurringTransactionMapper._guard(
        (c) => c.toJson(this as EndDateLimitedRecurringTransaction));
  }

  Map<String, dynamic> toMap() {
    return EndDateLimitedRecurringTransactionMapper._guard(
        (c) => c.toMap(this as EndDateLimitedRecurringTransaction));
  }

  EndDateLimitedRecurringTransactionCopyWith<
          EndDateLimitedRecurringTransaction,
          EndDateLimitedRecurringTransaction,
          EndDateLimitedRecurringTransaction>
      get copyWith => _EndDateLimitedRecurringTransactionCopyWithImpl(
          this as EndDateLimitedRecurringTransaction, $identity, $identity);
  @override
  String toString() {
    return EndDateLimitedRecurringTransactionMapper._guard(
        (c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            EndDateLimitedRecurringTransactionMapper._guard(
                (c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return EndDateLimitedRecurringTransactionMapper._guard((c) => c.hash(this));
  }
}

extension EndDateLimitedRecurringTransactionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EndDateLimitedRecurringTransaction, $Out> {
  EndDateLimitedRecurringTransactionCopyWith<$R,
          EndDateLimitedRecurringTransaction, $Out>
      get $asEndDateLimitedRecurringTransaction => $base.as((v, t, t2) =>
          _EndDateLimitedRecurringTransactionCopyWithImpl(v, t, t2));
}

abstract class EndDateLimitedRecurringTransactionCopyWith<
    $R,
    $In extends EndDateLimitedRecurringTransaction,
    $Out> implements RecurringTransactionCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<$R, Transaction,
      TransactionCopyWith<$R, Transaction, Transaction>> get transactions;
  @override
  $R call(
      {String? id,
      DateTime? startDate,
      double? amount,
      IntervalType? intervalType,
      String? description,
      String? transactionPartner,
      List<Transaction>? transactions,
      DateTime? endDate});
  EndDateLimitedRecurringTransactionCopyWith<$R2, $In, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EndDateLimitedRecurringTransactionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EndDateLimitedRecurringTransaction, $Out>
    implements
        EndDateLimitedRecurringTransactionCopyWith<$R,
            EndDateLimitedRecurringTransaction, $Out> {
  _EndDateLimitedRecurringTransactionCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EndDateLimitedRecurringTransaction> $mapper =
      EndDateLimitedRecurringTransactionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Transaction,
          TransactionCopyWith<$R, Transaction, Transaction>>
      get transactions => ListCopyWith($value.transactions,
          (v, t) => v.copyWith.$chain(t), (v) => call(transactions: v));
  @override
  $R call(
          {String? id,
          DateTime? startDate,
          double? amount,
          IntervalType? intervalType,
          String? description,
          String? transactionPartner,
          List<Transaction>? transactions,
          DateTime? endDate}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (startDate != null) #startDate: startDate,
        if (amount != null) #amount: amount,
        if (intervalType != null) #intervalType: intervalType,
        if (description != null) #description: description,
        if (transactionPartner != null) #transactionPartner: transactionPartner,
        if (transactions != null) #transactions: transactions,
        if (endDate != null) #endDate: endDate
      }));
  @override
  EndDateLimitedRecurringTransaction $make(CopyWithData data) =>
      EndDateLimitedRecurringTransaction(
          id: data.get(#id, or: $value.id),
          startDate: data.get(#startDate, or: $value.startDate),
          amount: data.get(#amount, or: $value.amount),
          intervalType: data.get(#intervalType, or: $value.intervalType),
          description: data.get(#description, or: $value.description),
          transactionPartner:
              data.get(#transactionPartner, or: $value.transactionPartner),
          transactions: data.get(#transactions, or: $value.transactions),
          endDate: data.get(#endDate, or: $value.endDate));

  @override
  EndDateLimitedRecurringTransactionCopyWith<$R2,
      EndDateLimitedRecurringTransaction, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EndDateLimitedRecurringTransactionCopyWithImpl($value, $cast, t);
}
