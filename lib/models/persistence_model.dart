import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:budgeteero/models/transaction.dart';
import 'package:dart_mappable/dart_mappable.dart';

import '../util/custom_date_time_mapper.dart';
import '../util/utils.dart';
import 'initial_balance.dart';

part 'persistence_model.mapper.dart';

@MappableClass(includeCustomMappers: [CustomDateTimeMapper()])
class PersistenceModel with PersistenceModelMappable {
  final List<Transaction> transactions;
  final InitialBalance initialBalance;
  final List<RecurringTransaction> recurringTransactions;

  PersistenceModel(
      {List<Transaction>? transactions,
      InitialBalance? initialBalance,
      List<RecurringTransaction>? recurringTransactions})
      : transactions = transactions ?? <Transaction>[],
        recurringTransactions =
            recurringTransactions ?? <RecurringTransaction>[],
        initialBalance = initialBalance ??
            InitialBalance(
                0,
                Utils.dateOnlyUTC(DateTime.timestamp())
                    .subtract(const Duration(days: 365)));
}
