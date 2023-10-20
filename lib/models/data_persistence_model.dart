import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:budgeteero/models/transaction.dart';
import 'package:dart_mappable/dart_mappable.dart';

import '../util/custom_date_time_mapper.dart';
import '../util/utils.dart';
import 'initial_balance.dart';

part 'data_persistence_model.mapper.dart';

@MappableClass(includeCustomMappers: [CustomDateTimeMapper()])
class DataPersistenceModel with DataPersistenceModelMappable {
  final InitialBalance initialBalance;
  final List<Transaction> transactions;
  final List<RecurringTransaction> recurringTransactions;

  DataPersistenceModel(
      {InitialBalance? initialBalance,
      List<Transaction>? transactions,
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
