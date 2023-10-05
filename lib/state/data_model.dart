import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../enums/recurring_transaction_order.dart';
import '../enums/transaction_order.dart';
import '../models/initial_balance.dart';
import '../models/transaction.dart';
import '../util/file_persister.dart';
import '../util/utils.dart';

class DataModel extends ChangeNotifier {
  final List<Transaction> _transactions = <Transaction>[];
  final List<RecurringTransaction> _recurringTransactions =
      <RecurringTransaction>[];
  InitialBalance _initialBalance = InitialBalance(
      0,
      Utils.dateOnlyUTC(DateTime.timestamp())
          .subtract(const Duration(days: 365)));
  TransactionOrder _balanceOrder = TransactionOrder.dateDescending;
  TransactionOrder _monthOrder = TransactionOrder.dateAscending;
  TransactionOrder _futureOrder = TransactionOrder.dateAscending;
  RecurringTransactionOrder _recurringOrder =
      RecurringTransactionOrder.startDateAscending;

  DataModel() {
    initialiseAllFromFile();
  }

  InitialBalance get initialBalance => _initialBalance;

  set initialBalance(InitialBalance value) {
    _initialBalance = value;
    writeStateToFile();
    notifyListeners();
  }

  initialiseAllFromFile() {
    FilePersister.readStateFromFile().then((data) {
      initialiseTransactionsTo(data.transactions);
      initialiseInitialBalanceTo(data.initialBalance);
      initialiseRecurringTransactionsTo(data.recurringTransactions);
    });
  }

  writeStateToFile() {
    FilePersister.writeStateToFile(
        _initialBalance, _transactions, _recurringTransactions);
  }

  initialiseInitialBalanceTo(InitialBalance value) {
    _initialBalance = value;
    notifyListeners();
  }

  TransactionOrder get balanceOrder => _balanceOrder;

  set balanceOrder(TransactionOrder value) {
    _balanceOrder = value;
    notifyListeners();
  }

  TransactionOrder get monthOrder => _monthOrder;

  set monthOrder(TransactionOrder value) {
    _monthOrder = value;
    notifyListeners();
  }

  TransactionOrder get futureOrder => _futureOrder;

  set futureOrder(TransactionOrder value) {
    _futureOrder = value;
    notifyListeners();
  }

  RecurringTransactionOrder get recurringOrder => _recurringOrder;

  set recurringOrder(RecurringTransactionOrder value) {
    _recurringOrder = value;
    notifyListeners();
  }

  UnmodifiableListView<RecurringTransaction> get recurringTransactions {
    return UnmodifiableListView(_recurringTransactions);
  }

  void initialiseRecurringTransactionsTo(
      List<RecurringTransaction> recurringTransactions) {
    _recurringTransactions.clear();
    _recurringTransactions.addAll(recurringTransactions);
    notifyListeners();
  }

  void addRecurringTransaction(RecurringTransaction recurringTransaction) {
    _recurringTransactions.add(recurringTransaction);
    writeStateToFile();
    notifyListeners();
  }

  void removeRecurringTransactions(
      List<RecurringTransaction> recurringTransactions) {
    _recurringTransactions
        .removeWhere((t) => recurringTransactions.contains(t));
    writeStateToFile();
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
    List<Transaction> pastTransactions = _transactions
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
    return UnmodifiableListView(_transactions
        .where((t) => t.date.isAfter(Utils.dateOnlyUTC(DateTime.timestamp()))));
  }

  void initialiseTransactionsTo(List<Transaction> transactions) {
    _transactions.clear();
    _transactions.addAll(transactions);
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    writeStateToFile();
    notifyListeners();
  }

  void removeTransactions(List<Transaction> transactions) {
    _transactions.removeWhere((t) => transactions.contains(t));
    for (RecurringTransaction rt in _recurringTransactions) {
      rt.transactions.removeWhere((t) => transactions.contains(t));
    }
    writeStateToFile();
    notifyListeners();
  }

  UnmodifiableListView<Transaction> getTransactionsForMonth(
      DateTime monthAndYear) {
    List<Transaction> transactions = _transactions.where((t) {
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
