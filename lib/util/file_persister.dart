import 'dart:io';

import 'package:budgeteero/models/initial_balance.dart';
import 'package:budgeteero/models/persistence_model.dart';
import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:path_provider/path_provider.dart';

import '../models/transaction.dart';

class FilePersister {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/state.json');
  }

  static void writeStringToFile(String string) async {
    final file = await _localFile;
    file.writeAsString(string, flush: true, mode: FileMode.writeOnly);
  }

  static Future<String> readStringFromFile() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }

  static void writeStateToFile(
      InitialBalance initialBalance, List<Transaction> transactions, List<RecurringTransaction> recurringTransactions) async {
    final data = PersistenceModel(
        initialBalance: initialBalance, transactions: transactions, recurringTransactions: recurringTransactions);
    final jsonData = data.toJson();
    writeStringToFile(jsonData);
  }

  static Future<PersistenceModel> readStateFromFile() async {
    String fileString = await readStringFromFile();
    if (fileString.isEmpty) {
      return PersistenceModel();
    }
    return PersistenceModelMapper.fromJson(fileString);
  }
}
