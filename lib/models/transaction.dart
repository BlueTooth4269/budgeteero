import 'package:dart_mappable/dart_mappable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../util/custom_date_time_mapper.dart';

part 'transaction.mapper.dart';

@MappableClass(
    hook: UnmappedPropertiesHook('uuid'),
    includeCustomMappers: [CustomDateTimeMapper()])
class Transaction with TransactionMappable {
  late String id;
  double amount;
  String description;
  String transactionPartner;
  DateTime date;
  Uuid uuid = const Uuid();

  Transaction(this.id, this.amount, this.description, this.transactionPartner,
      this.date);

  Transaction.createNew(
      this.amount, this.description, this.transactionPartner, this.date) {
    id = uuid.v1();
  }

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType && id == (other as Transaction).id;

  @override
  int get hashCode => id.hashCode;

  bool containsString(String string) {
    string = string.toLowerCase();
    return (string.isEmpty ||
        DateFormat('dd.MM.yyyy').format(date).toLowerCase().contains(string) ||
        DateFormat('dd/MM/yyyy').format(date).toLowerCase().contains(string) ||
        DateFormat('dd-MM-yyyy').format(date).toLowerCase().contains(string) ||
        transactionPartner.toLowerCase().contains(string) ||
        description.toLowerCase().contains(string) ||
        amount.toString().toLowerCase().contains(string));
  }
}
