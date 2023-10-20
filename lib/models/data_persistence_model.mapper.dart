// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'data_persistence_model.dart';

class DataPersistenceModelMapper extends ClassMapperBase<DataPersistenceModel> {
  DataPersistenceModelMapper._();

  static DataPersistenceModelMapper? _instance;
  static DataPersistenceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataPersistenceModelMapper._());
      MapperContainer.globals.useAll([CustomDateTimeMapper()]);
      InitialBalanceMapper.ensureInitialized();
      TransactionMapper.ensureInitialized();
      RecurringTransactionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'DataPersistenceModel';

  static InitialBalance _$initialBalance(DataPersistenceModel v) =>
      v.initialBalance;
  static const Field<DataPersistenceModel, InitialBalance> _f$initialBalance =
      Field('initialBalance', _$initialBalance, opt: true);
  static List<Transaction> _$transactions(DataPersistenceModel v) =>
      v.transactions;
  static const Field<DataPersistenceModel, List<Transaction>> _f$transactions =
      Field('transactions', _$transactions, opt: true);
  static List<RecurringTransaction> _$recurringTransactions(
          DataPersistenceModel v) =>
      v.recurringTransactions;
  static const Field<DataPersistenceModel, List<RecurringTransaction>>
      _f$recurringTransactions =
      Field('recurringTransactions', _$recurringTransactions, opt: true);

  @override
  final Map<Symbol, Field<DataPersistenceModel, dynamic>> fields = const {
    #initialBalance: _f$initialBalance,
    #transactions: _f$transactions,
    #recurringTransactions: _f$recurringTransactions,
  };

  static DataPersistenceModel _instantiate(DecodingData data) {
    return DataPersistenceModel(
        initialBalance: data.dec(_f$initialBalance),
        transactions: data.dec(_f$transactions),
        recurringTransactions: data.dec(_f$recurringTransactions));
  }

  @override
  final Function instantiate = _instantiate;

  static DataPersistenceModel fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<DataPersistenceModel>(map));
  }

  static DataPersistenceModel fromJson(String json) {
    return _guard((c) => c.fromJson<DataPersistenceModel>(json));
  }
}

mixin DataPersistenceModelMappable {
  String toJson() {
    return DataPersistenceModelMapper._guard(
        (c) => c.toJson(this as DataPersistenceModel));
  }

  Map<String, dynamic> toMap() {
    return DataPersistenceModelMapper._guard(
        (c) => c.toMap(this as DataPersistenceModel));
  }

  DataPersistenceModelCopyWith<DataPersistenceModel, DataPersistenceModel,
          DataPersistenceModel>
      get copyWith => _DataPersistenceModelCopyWithImpl(
          this as DataPersistenceModel, $identity, $identity);
  @override
  String toString() {
    return DataPersistenceModelMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DataPersistenceModelMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return DataPersistenceModelMapper._guard((c) => c.hash(this));
  }
}

extension DataPersistenceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DataPersistenceModel, $Out> {
  DataPersistenceModelCopyWith<$R, DataPersistenceModel, $Out>
      get $asDataPersistenceModel =>
          $base.as((v, t, t2) => _DataPersistenceModelCopyWithImpl(v, t, t2));
}

abstract class DataPersistenceModelCopyWith<
    $R,
    $In extends DataPersistenceModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  InitialBalanceCopyWith<$R, InitialBalance, InitialBalance> get initialBalance;
  ListCopyWith<$R, Transaction,
      TransactionCopyWith<$R, Transaction, Transaction>> get transactions;
  ListCopyWith<
      $R,
      RecurringTransaction,
      RecurringTransactionCopyWith<$R, RecurringTransaction,
          RecurringTransaction>> get recurringTransactions;
  $R call(
      {InitialBalance? initialBalance,
      List<Transaction>? transactions,
      List<RecurringTransaction>? recurringTransactions});
  DataPersistenceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DataPersistenceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DataPersistenceModel, $Out>
    implements DataPersistenceModelCopyWith<$R, DataPersistenceModel, $Out> {
  _DataPersistenceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataPersistenceModel> $mapper =
      DataPersistenceModelMapper.ensureInitialized();
  @override
  InitialBalanceCopyWith<$R, InitialBalance, InitialBalance>
      get initialBalance => ($value.initialBalance as InitialBalance)
          .copyWith
          .$chain((v) => call(initialBalance: v));
  @override
  ListCopyWith<$R, Transaction,
          TransactionCopyWith<$R, Transaction, Transaction>>
      get transactions => ListCopyWith($value.transactions,
          (v, t) => v.copyWith.$chain(t), (v) => call(transactions: v));
  @override
  ListCopyWith<
      $R,
      RecurringTransaction,
      RecurringTransactionCopyWith<$R, RecurringTransaction,
          RecurringTransaction>> get recurringTransactions => ListCopyWith(
      $value.recurringTransactions,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(recurringTransactions: v));
  @override
  $R call(
          {Object? initialBalance = $none,
          Object? transactions = $none,
          Object? recurringTransactions = $none}) =>
      $apply(FieldCopyWithData({
        if (initialBalance != $none) #initialBalance: initialBalance,
        if (transactions != $none) #transactions: transactions,
        if (recurringTransactions != $none)
          #recurringTransactions: recurringTransactions
      }));
  @override
  DataPersistenceModel $make(CopyWithData data) => DataPersistenceModel(
      initialBalance: data.get(#initialBalance, or: $value.initialBalance),
      transactions: data.get(#transactions, or: $value.transactions),
      recurringTransactions:
          data.get(#recurringTransactions, or: $value.recurringTransactions));

  @override
  DataPersistenceModelCopyWith<$R2, DataPersistenceModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DataPersistenceModelCopyWithImpl($value, $cast, t);
}
