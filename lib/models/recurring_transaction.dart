import 'package:budgeteero/models/transaction.dart';
import 'package:budgeteero/util/custom_date_time_mapper.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../enums/interval_type.dart';
import '../util/constants.dart';
import '../util/utils.dart';

part 'recurring_transaction.mapper.dart';

@MappableClass(
    discriminatorKey: "type",
    hook: UnmappedPropertiesHook('uuid'),
    includeCustomMappers: [CustomDateTimeMapper()])
class RecurringTransaction with RecurringTransactionMappable {
  DateTime _startDate;

  DateTime get startDate => _startDate;

  set startDate(DateTime value) {
    _startDate = Utils.dateOnlyUTC(value);
  }

  String get endingString => "Indefinite";

  late String id;
  double amount;
  IntervalType intervalType;
  String description;
  String transactionPartner;
  late List<Transaction> transactions;
  Uuid uuid = const Uuid();

  RecurringTransaction(
      {required this.id,
      required DateTime startDate,
      required this.amount,
      required this.intervalType,
      required this.description,
      required this.transactionPartner,
      required this.transactions})
      : _startDate = Utils.dateOnlyUTC(startDate) {
    id = uuid.v1();
  }

  RecurringTransaction.createNew(
      {required DateTime startDate,
      required this.amount,
      required this.intervalType,
      required this.description,
      required this.transactionPartner})
      : _startDate = Utils.dateOnlyUTC(startDate) {
    id = uuid.v1();
    transactions = _getDatesForPeriod(_startDate, Constants.latestDate)
        .map((date) => Transaction.createNew(
            amount, description, transactionPartner, date))
        .toList();
  }

  //start and end are inclusive
  List<Transaction> getTransactionsForPeriod({DateTime? start, DateTime? end}) {
    start = start ?? _startDate;
    end = end ?? Constants.latestDate;

    return transactions
        .where((t) => !start!.isAfter(t.date) && !end!.isBefore(t.date))
        .toList();
  }

  //start and end are inclusive
  List<DateTime> _getDatesForPeriod(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    if (end.isBefore(start)) {
      return dates;
    }
    DateTime date = startDate;
    int rep = 1;
    while (!end.isBefore(date)) {
      if (!start.isAfter(date)) {
        dates.add(date);
      }
      date = _getDateWithAddedIntervalTimes(startDate, intervalType, rep);
      rep++;
    }
    return dates;
  }

  DateTime _getDateWithAddedIntervalTimes(
      DateTime date, IntervalType intervalType, int amount) {
    switch (intervalType) {
      case IntervalType.daily:
        return DateTime.utc(date.year, date.month, date.day + amount);
      case IntervalType.weekly:
        return DateTime.utc(date.year, date.month, date.day + amount * 7);
      case IntervalType.yearly:
        return DateTime.utc(date.year + amount, date.month, date.day);
      case IntervalType.monthly:
      default:
        return DateTime.utc(date.year, date.month + amount, date.day);
    }
  }

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType &&
      id == (other as RecurringTransaction).id;

  @override
  int get hashCode => id.hashCode;
}

@MappableClass()
class RepetitionLimitedRecurringTransaction extends RecurringTransaction
    with RepetitionLimitedRecurringTransactionMappable {
  int repetitions;

  @override
  String get endingString => "$repetitions repetitions";

  RepetitionLimitedRecurringTransaction(
      {required super.id,
      required super.startDate,
      required super.amount,
      required super.intervalType,
      required super.description,
      required super.transactionPartner,
      required super.transactions,
      required this.repetitions});

  RepetitionLimitedRecurringTransaction.createNew(
      {required super.startDate,
      required super.amount,
      required super.intervalType,
      required super.description,
      required super.transactionPartner,
      required this.repetitions})
      : super.createNew();

  @override
  List<DateTime> _getDatesForPeriod(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    if (end.isBefore(start)) {
      return dates;
    }
    DateTime date = startDate;
    int rep = 1;
    while (!end.isBefore(date) && (rep <= repetitions)) {
      if (!start.isAfter(date)) {
        dates.add(date);
      }
      date = _getDateWithAddedIntervalTimes(startDate, intervalType, rep);
      rep++;
    }
    return dates;
  }
}

@MappableClass()
class EndDateLimitedRecurringTransaction extends RecurringTransaction
    with EndDateLimitedRecurringTransactionMappable {
  DateTime endDate;

  @override
  String get endingString =>
      "Until: ${DateFormat("dd.MM.yyyy").format(endDate)}";

  EndDateLimitedRecurringTransaction(
      {required super.id,
      required super.startDate,
      required super.amount,
      required super.intervalType,
      required super.description,
      required super.transactionPartner,
      required super.transactions,
      required this.endDate});

  EndDateLimitedRecurringTransaction.createNew(
      {required super.startDate,
      required super.amount,
      required super.intervalType,
      required super.description,
      required super.transactionPartner,
      required this.endDate})
      : super.createNew();

  @override
  List<DateTime> _getDatesForPeriod(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    if (end.isBefore(start) || endDate.isBefore(start)) {
      return dates;
    }
    DateTime date = startDate;
    int rep = 1;
    while (!end.isBefore(date) && (!endDate.isBefore(date))) {
      if (!start.isAfter(date)) {
        dates.add(date);
      }
      date = _getDateWithAddedIntervalTimes(startDate, intervalType, rep);
      rep++;
    }
    return dates;
  }
}
