import 'package:budgeteero/models/data_persistence_model.dart';
import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:budgeteero/util/json_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../enums/recurring_transaction_order.dart';
import '../enums/transaction_order.dart';
import '../models/initial_balance.dart';
import '../models/transaction.dart';
import '../util/io_service.dart';
import '../util/utils.dart';

class DataModel extends ChangeNotifier {
  final List<Transaction> _transactions = <Transaction>[];
  List<Transaction> _fetchedTransactions = <Transaction>[];
  final List<RecurringTransaction> _recurringTransactions =
      <RecurringTransaction>[];
  List<RecurringTransaction> _fetchedRecurringTransactions =
      <RecurringTransaction>[];
  InitialBalance _initialBalance = InitialBalance(
      0,
      Utils.dateOnlyUTC(DateTime.timestamp())
          .subtract(const Duration(days: 365)));
  InitialBalance _fetchedInitialBalance = InitialBalance(
      0,
      Utils.dateOnlyUTC(DateTime.timestamp())
          .subtract(const Duration(days: 365)));
  TransactionOrder _balanceOrder = TransactionOrder.dateDescending;
  TransactionOrder _monthOrder = TransactionOrder.dateAscending;
  TransactionOrder _futureOrder = TransactionOrder.dateAscending;
  RecurringTransactionOrder _recurringOrder =
      RecurringTransactionOrder.startDateAscending;
  bool _unsavedChanges = false;
  String? _dataFilePath;
  bool _finishedLoadingFromFile = false;

  bool get finishedLoadingFromFile => _finishedLoadingFromFile;

  bool get unsavedChanges => _unsavedChanges;

  InitialBalance get initialBalance => _initialBalance;

  void setInitialBalance(InitialBalance value) {
    _initialBalance = value;
    _unsavedChanges = !_initialBalance.equals(_fetchedInitialBalance);
    notifyListeners();
  }

  Future<void> initialiseDataFromFile(Future<String> filePath) async {
    _dataFilePath = '${await filePath}/state.json';
    String json = await IOService.readStringFromFilePath(_dataFilePath!);
    DataPersistenceModel data = JsonService.readDataStateFromJsonString(json);
    initialiseTransactionsTo(data.transactions);
    initialiseInitialBalanceTo(data.initialBalance);
    initialiseRecurringTransactionsTo(data.recurringTransactions);
    _finishedLoadingFromFile = true;
    notifyListeners();
  }

  Future<void> writeDataStateToFile() async {
    if (_dataFilePath != null) {
      String json = JsonService.writeDataStateToJsonString(
          _initialBalance, _transactions, _recurringTransactions);
      await IOService.writeStringToFilePath(json, _dataFilePath!);
      _fetchedInitialBalance = _initialBalance;
      _fetchedTransactions = [..._transactions];
      _fetchedRecurringTransactions = _recurringTransactions
          .map((r) => RecurringTransaction.copy(r))
          .toList();
      _unsavedChanges = false;
      notifyListeners();
    }
  }

  void initialiseInitialBalanceTo(InitialBalance value) {
    _initialBalance = value;
    _fetchedInitialBalance = value;
  }

  TransactionOrder get balanceOrder => _balanceOrder;

  void setBalanceOrder(TransactionOrder value) {
    _balanceOrder = value;
    notifyListeners();
  }

  TransactionOrder get monthOrder => _monthOrder;

  void setMonthOrder(TransactionOrder value) {
    _monthOrder = value;
    notifyListeners();
  }

  TransactionOrder get futureOrder => _futureOrder;

  set futureOrder(TransactionOrder value) {
    _futureOrder = value;
    notifyListeners();
  }

  RecurringTransactionOrder get recurringOrder => _recurringOrder;

  void setRecurringOrder(RecurringTransactionOrder value) {
    _recurringOrder = value;
    notifyListeners();
  }

  UnmodifiableListView<RecurringTransaction> get recurringTransactions {
    return UnmodifiableListView([..._recurringTransactions]);
  }

  void initialiseRecurringTransactionsTo(
      List<RecurringTransaction> recurringTransactions) {
    _recurringTransactions.clear();
    _recurringTransactions.addAll(recurringTransactions);
    _fetchedRecurringTransactions = _recurringTransactions
        .map((r) => RecurringTransaction.copy(r))
        .toList();
  }

  void addRecurringTransaction(RecurringTransaction recurringTransaction) {
    _recurringTransactions.add(recurringTransaction);
    _unsavedChanges =
        !_recurringTransactions.equals(_fetchedRecurringTransactions);
    notifyListeners();
  }

  void removeRecurringTransactions(
      List<RecurringTransaction> recurringTransactions) {
    _recurringTransactions
        .removeWhere((t) => recurringTransactions.contains(t));
    _unsavedChanges =
        !_recurringTransactions.equals(_fetchedRecurringTransactions);
    notifyListeners();
  }

  UnmodifiableListView<Transaction> get transactions {
    List<Transaction> transactionsFromRecurring = [];
    for (RecurringTransaction t in _recurringTransactions) {
      transactionsFromRecurring.addAll(t.transactions);
    }
    return UnmodifiableListView(
        [..._transactions, ...transactionsFromRecurring]);
  }

  UnmodifiableListView<Transaction> get pastTransactions {
    List<Transaction> pastTransactions = [..._transactions]
        .where((t) => !t.date.isAfter(Utils.dateOnlyUTC(DateTime.timestamp())))
        .toList();
    List<Transaction> pastTransactionsFromRecurring = [];
    for (RecurringTransaction t in _recurringTransactions) {
      pastTransactionsFromRecurring.addAll(t.getTransactionsForPeriod(
          end: Utils.dateOnlyUTC(DateTime.timestamp())));
    }

    return UnmodifiableListView(
        [...pastTransactions, ...pastTransactionsFromRecurring]);
  }

  UnmodifiableListView<Transaction> get futureTransactions {
    return UnmodifiableListView([..._transactions]
        .where((t) => t.date.isAfter(Utils.dateOnlyUTC(DateTime.timestamp()))));
  }

  void initialiseTransactionsTo(List<Transaction> transactions) {
    _transactions.clear();
    _transactions.addAll(transactions);
    _fetchedTransactions = [..._transactions];
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    _unsavedChanges = !_transactions.equals(_fetchedTransactions);
    notifyListeners();
  }

  void removeTransactions(List<Transaction> transactions) {
    _transactions.removeWhere((t) => transactions.contains(t));
    for (RecurringTransaction rt in _recurringTransactions) {
      rt.transactions.removeWhere((t) => transactions.contains(t));
    }
    _unsavedChanges = !(_transactions.equals(_fetchedTransactions) &&
        _recurringTransactions.equals(_fetchedRecurringTransactions));
    notifyListeners();
  }

  UnmodifiableListView<Transaction> getTransactionsForMonth(
      DateTime monthAndYear) {
    List<Transaction> transactions = [..._transactions].where((t) {
      return t.date.month == monthAndYear.month &&
          t.date.year == monthAndYear.year;
    }).toList();

    List<Transaction> transactionsFromRecurring = [];
    for (RecurringTransaction t in _recurringTransactions) {
      transactionsFromRecurring.addAll(t.getTransactionsForPeriod(
          start: monthAndYear,
          end: DateTime.utc(
              monthAndYear.year,
              monthAndYear.month,
              DateUtils.getDaysInMonth(
                  monthAndYear.year, monthAndYear.month))));
    }

    return UnmodifiableListView(
        [...transactions, ...transactionsFromRecurring]);
  }

  double get balance {
    return pastTransactions.isEmpty
        ? initialBalance.balance
        : initialBalance.balance +
            pastTransactions.map((t) => t.amount).reduce((v, e) => v + e);
  }

  double getBalanceAtStartOfMonth(DateTime monthAndYear) {
    DateTime lastDayOfPrevMonth = DateTime.utc(
        monthAndYear.year,
        monthAndYear.month - 1,
        DateUtils.getDaysInMonth(monthAndYear.year, monthAndYear.month - 1));
    return getBalanceForDate(lastDayOfPrevMonth);
  }

  double getBalanceAtEndOfMonth(DateTime monthAndYear) {
    DateTime lastDayOfMonth = DateTime.utc(
        monthAndYear.year,
        monthAndYear.month,
        DateUtils.getDaysInMonth(monthAndYear.year, monthAndYear.month));

    return getBalanceForDate(lastDayOfMonth);
  }

  double getBalanceForDate(DateTime date) {
    date = Utils.dateOnlyUTC(date);

    List<Transaction> transactionsUntilDate =
        _transactions.where((element) => !element.date.isAfter(date)).toList();

    for (RecurringTransaction t in _recurringTransactions) {
      transactionsUntilDate.addAll(t.getTransactionsForPeriod(end: date));
    }

    return transactionsUntilDate.isEmpty
        ? initialBalance.balance
        : initialBalance.balance +
            transactionsUntilDate.map((t) => t.amount).reduce((v, e) => v + e);
  }

  double getMonthlyNet(DateTime monthAndYear) {
    return getTransactionsForMonth(monthAndYear).isEmpty
        ? 0
        : getTransactionsForMonth(monthAndYear)
            .map((t) => t.amount)
            .reduce((value, element) => value += element);
  }

  double getOutstandingBalanceForMonth(DateTime monthAndYear) {
    List<Transaction> transactionsUntilEndOfMonth = getTransactionsForMonth(
            monthAndYear)
        .where((t) => t.date.isAfter(Utils.dateOnlyUTC(DateTime.timestamp())))
        .toList();

    return transactionsUntilEndOfMonth.isEmpty
        ? 0
        : transactionsUntilEndOfMonth
            .map((t) => t.amount)
            .reduce((v, e) => v + e);
  }

  double getLowestBalanceInMonth(DateTime monthAndYear) {
    double lowestBalance = getBalanceForDate(
        DateTime.utc(monthAndYear.year, monthAndYear.month, 1));

    for (int i = 2;
        i <= DateUtils.getDaysInMonth(monthAndYear.year, monthAndYear.month);
        i++) {
      double balance = getBalanceForDate(
          DateTime.utc(monthAndYear.year, monthAndYear.month, i));
      if (balance < lowestBalance) {
        lowestBalance = balance;
      }
    }

    return lowestBalance;
  }

  DateTime? getEarliestTransactionDate() {
    List<DateTime> dates =
        List<DateTime>.from(_transactions.map((e) => e.date));
    dates.addAll(_recurringTransactions.map((e) => e.startDate).toList());
    if (dates.isEmpty) {
      return null;
    } else {
      return dates.sorted().first;
    }
  }
}
