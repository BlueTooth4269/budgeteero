// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'persistence_model.dart';

class PersistenceModelMapper extends ClassMapperBase<PersistenceModel> {
  PersistenceModelMapper._();

  static PersistenceModelMapper? _instance;
  static PersistenceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersistenceModelMapper._());
      MapperContainer.globals.useAll([CustomDateTimeMapper()]);
      TransactionMapper.ensureInitialized();
      InitialBalanceMapper.ensureInitialized();
      RecurringTransactionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'PersistenceModel';

  static List<Transaction> _$transactions(PersistenceModel v) => v.transactions;
  static const Field<PersistenceModel, List<Transaction>> _f$transactions =
      Field('transactions', _$transactions, opt: true);
  static InitialBalance _$initialBalance(PersistenceModel v) =>
      v.initialBalance;
  static const Field<PersistenceModel, InitialBalance> _f$initialBalance =
      Field('initialBalance', _$initialBalance, opt: true);
  static List<RecurringTransaction> _$recurringTransactions(
          PersistenceModel v) =>
      v.recurringTransactions;
  static const Field<PersistenceModel, List<RecurringTransaction>>
      _f$recurringTransactions =
      Field('recurringTransactions', _$recurringTransactions, opt: true);

  @override
  final Map<Symbol, Field<PersistenceModel, dynamic>> fields = const {
    #transactions: _f$transactions,
    #initialBalance: _f$initialBalance,
    #recurringTransactions: _f$recurringTransactions,
  };

  static PersistenceModel _instantiate(DecodingData data) {
    return PersistenceModel(
        transactions: data.dec(_f$transactions),
        initialBalance: data.dec(_f$initialBalance),
        recurringTransactions: data.dec(_f$recurringTransactions));
  }

  @override
  final Function instantiate = _instantiate;

  static PersistenceModel fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<PersistenceModel>(map));
  }

  static PersistenceModel fromJson(String json) {
    return _guard((c) => c.fromJson<PersistenceModel>(json));
  }
}

mixin PersistenceModelMappable {
  String toJson() {
    return PersistenceModelMapper._guard(
        (c) => c.toJson(this as PersistenceModel));
  }

  Map<String, dynamic> toMap() {
    return PersistenceModelMapper._guard(
        (c) => c.toMap(this as PersistenceModel));
  }

  PersistenceModelCopyWith<PersistenceModel, PersistenceModel, PersistenceModel>
      get copyWith => _PersistenceModelCopyWithImpl(
          this as PersistenceModel, $identity, $identity);
  @override
  String toString() {
    return PersistenceModelMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PersistenceModelMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return PersistenceModelMapper._guard((c) => c.hash(this));
  }
}

extension PersistenceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PersistenceModel, $Out> {
  PersistenceModelCopyWith<$R, PersistenceModel, $Out>
      get $asPersistenceModel =>
          $base.as((v, t, t2) => _PersistenceModelCopyWithImpl(v, t, t2));
}

abstract class PersistenceModelCopyWith<$R, $In extends PersistenceModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Transaction,
      TransactionCopyWith<$R, Transaction, Transaction>> get transactions;
  InitialBalanceCopyWith<$R, InitialBalance, InitialBalance> get initialBalance;
  ListCopyWith<
      $R,
      RecurringTransaction,
      RecurringTransactionCopyWith<$R, RecurringTransaction,
          RecurringTransaction>> get recurringTransactions;
  $R call(
      {List<Transaction>? transactions,
      InitialBalance? initialBalance,
      List<RecurringTransaction>? recurringTransactions});
  PersistenceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PersistenceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PersistenceModel, $Out>
    implements PersistenceModelCopyWith<$R, PersistenceModel, $Out> {
  _PersistenceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PersistenceModel> $mapper =
      PersistenceModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Transaction,
          TransactionCopyWith<$R, Transaction, Transaction>>
      get transactions => ListCopyWith($value.transactions,
          (v, t) => v.copyWith.$chain(t), (v) => call(transactions: v));
  @override
  InitialBalanceCopyWith<$R, InitialBalance, InitialBalance>
      get initialBalance => ($value.initialBalance as InitialBalance)
          .copyWith
          .$chain((v) => call(initialBalance: v));
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
          {Object? transactions = $none,
          Object? initialBalance = $none,
          Object? recurringTransactions = $none}) =>
      $apply(FieldCopyWithData({
        if (transactions != $none) #transactions: transactions,
        if (initialBalance != $none) #initialBalance: initialBalance,
        if (recurringTransactions != $none)
          #recurringTransactions: recurringTransactions
      }));
  @override
  PersistenceModel $make(CopyWithData data) => PersistenceModel(
      transactions: data.get(#transactions, or: $value.transactions),
      initialBalance: data.get(#initialBalance, or: $value.initialBalance),
      recurringTransactions:
          data.get(#recurringTransactions, or: $value.recurringTransactions));

  @override
  PersistenceModelCopyWith<$R2, PersistenceModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PersistenceModelCopyWithImpl($value, $cast, t);
}
