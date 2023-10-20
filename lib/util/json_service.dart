import '../enums/persistence_enums.dart';
import '../models/data_persistence_model.dart';
import '../models/initial_balance.dart';
import '../models/recurring_transaction.dart';
import '../models/settings_persistence_model.dart';
import '../models/transaction.dart';

class JsonService {
  static String writeDataStateToJsonString(
      InitialBalance initialBalance,
      List<Transaction> transactions,
      List<RecurringTransaction> recurringTransactions) {
    final data = DataPersistenceModel(
        initialBalance: initialBalance,
        transactions: transactions,
        recurringTransactions: recurringTransactions);
    return data.toJson();
  }

  static DataPersistenceModel readDataStateFromJsonString(String json) {
    if (json.isEmpty) {
      return DataPersistenceModel();
    }
    return DataPersistenceModelMapper.fromJson(json);
  }

  static String writeSettingsStateToJsonString(SaveMethod saveMethod,
      SaveLocationOption saveLocationOption, String? customSaveLocation) {
    final settings = SettingsPersistenceModel(
        selectedSaveMethod: saveMethod,
        selectedSaveLocationOption: saveLocationOption,
        customSaveLocation: customSaveLocation);
    return settings.toJson();
  }

  static SettingsPersistenceModel readSettingsStateFromFile(String json) {
    if (json.isEmpty) {
      return SettingsPersistenceModel();
    }
    return SettingsPersistenceModelMapper.fromJson(json);
  }
}