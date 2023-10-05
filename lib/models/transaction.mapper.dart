// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'transaction.dart';

class TransactionMapper extends ClassMapperBase<Transaction> {
  TransactionMapper._();

  static TransactionMapper? _instance;
  static TransactionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TransactionMapper._());
      MapperContainer.globals.useAll([CustomDateTimeMapper()]);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Transaction';

  static String _$id(Transaction v) => v.id;
  static const Field<Transaction, String> _f$id = Field('id', _$id);
  static double _$amount(Transaction v) => v.amount;
  static const Field<Transaction, double> _f$amount = Field('amount', _$amount);
  static String _$description(Transaction v) => v.description;
  static const Field<Transaction, String> _f$description =
      Field('description', _$description);
  static String _$transactionPartner(Transaction v) => v.transactionPartner;
  static const Field<Transaction, String> _f$transactionPartner =
      Field('transactionPartner', _$transactionPartner);
  static DateTime _$date(Transaction v) => v.date;
  static const Field<Transaction, DateTime> _f$date = Field('date', _$date);
  static Uuid _$uuid(Transaction v) => v.uuid;
  static const Field<Transaction, Uuid> _f$uuid =
      Field('uuid', _$uuid, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<Transaction, dynamic>> fields = const {
    #id: _f$id,
    #amount: _f$amount,
    #description: _f$description,
    #transactionPartner: _f$transactionPartner,
    #date: _f$date,
    #uuid: _f$uuid,
  };

  @override
  final MappingHook hook = const UnmappedPropertiesHook('uuid');
  static Transaction _instantiate(DecodingData data) {
    return Transaction(
        data.dec(_f$id),
        data.dec(_f$amount),
        data.dec(_f$description),
        data.dec(_f$transactionPartner),
        data.dec(_f$date));
  }

  @override
  final Function instantiate = _instantiate;

  static Transaction fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Transaction>(map));
  }

  static Transaction fromJson(String json) {
    return _guard((c) => c.fromJson<Transaction>(json));
  }
}

mixin TransactionMappable {
  String toJson() {
    return TransactionMapper._guard((c) => c.toJson(this as Transaction));
  }

  Map<String, dynamic> toMap() {
    return TransactionMapper._guard((c) => c.toMap(this as Transaction));
  }

  TransactionCopyWith<Transaction, Transaction, Transaction> get copyWith =>
      _TransactionCopyWithImpl(this as Transaction, $identity, $identity);
  @override
  String toString() {
    return TransactionMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TransactionMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return TransactionMapper._guard((c) => c.hash(this));
  }
}

extension TransactionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Transaction, $Out> {
  TransactionCopyWith<$R, Transaction, $Out> get $asTransaction =>
      $base.as((v, t, t2) => _TransactionCopyWithImpl(v, t, t2));
}

abstract class TransactionCopyWith<$R, $In extends Transaction, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      double? amount,
      String? description,
      String? transactionPartner,
      DateTime? date});
  TransactionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TransactionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Transaction, $Out>
    implements TransactionCopyWith<$R, Transaction, $Out> {
  _TransactionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Transaction> $mapper =
      TransactionMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          double? amount,
          String? description,
          String? transactionPartner,
          DateTime? date}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (amount != null) #amount: amount,
        if (description != null) #description: description,
        if (transactionPartner != null) #transactionPartner: transactionPartner,
        if (date != null) #date: date
      }));
  @override
  Transaction $make(CopyWithData data) => Transaction(
      data.get(#id, or: $value.id),
      data.get(#amount, or: $value.amount),
      data.get(#description, or: $value.description),
      data.get(#transactionPartner, or: $value.transactionPartner),
      data.get(#date, or: $value.date));

  @override
  TransactionCopyWith<$R2, Transaction, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TransactionCopyWithImpl($value, $cast, t);
}
