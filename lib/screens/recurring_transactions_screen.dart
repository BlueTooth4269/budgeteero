import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:budgeteero/screens/modal/create_recurring_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/persistence_enums.dart';
import '../enums/recurring_transaction_order.dart';
import '../state/data_model.dart';
import '../state/settings_model.dart';
import '../widgets/layout/list_title_bar.dart';
import '../widgets/layout/page_layout.dart';
import '../widgets/layout/recurring_transaction_list.dart';

class RecurringTransactionsScreen extends StatefulWidget {
  final String title;

  const RecurringTransactionsScreen({super.key, required this.title});

  @override
  State<RecurringTransactionsScreen> createState() =>
      _RecurringTransactionsScreenState();
}

class _RecurringTransactionsScreenState
    extends State<RecurringTransactionsScreen> {
  final List<RecurringTransaction> selectedTransactions =
      <RecurringTransaction>[];
  final ScrollController _scrollController = ScrollController();
  List<String> _searchStrings = [];

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void openCreateRecurringTransactionDialog(BuildContext context) {
    setState(() => selectedTransactions.clear());
    final DataModel data = context.read<DataModel>();

    showDialog<RecurringTransaction>(
      context: context,
      builder: (BuildContext context) => CreateRecurringTransactionDialog(),
    ).then((result) {
      if (result != null) {
        data.addRecurringTransaction(result);
        if (context.read<SettingsModel>().selectedSaveMethod ==
            SaveMethod.auto) {
          data.writeDataStateToFile();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Changes Saved'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  void onSearchFieldChanged(String string) {
    setState(() {
      selectedTransactions.clear();
      _searchStrings = string.split(' ');
    });
  }

  bool transactionIncludedInSearchResults(RecurringTransaction transaction) {
    return _searchStrings.isEmpty ||
        _searchStrings.any((string) => transaction.containsString(string));
  }

  void deleteTransactions(List<RecurringTransaction> transactions) {
    DataModel data = context.read<DataModel>();

    data.removeRecurringTransactions(transactions);
    if (context.read<SettingsModel>().selectedSaveMethod == SaveMethod.auto) {
      data.writeDataStateToFile();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes Saved'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void changeOrder(RecurringTransactionOrder order) {
    context.read<DataModel>().setRecurringOrder(order);
    _scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return PageLayoutFrame(
      title: widget.title,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 15.0),
            child: Column(
              children: [
                SizedBox(
                  width: 260,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        {openCreateRecurringTransactionDialog(context)},
                    icon: const Icon(Icons.add_circle_sharp),
                    label: const Text('Add Recurring Transaction'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black12),
          const SizedBox(height: 10),
          ListTitleBar<RecurringTransactionOrder>(
            enumValues: RecurringTransactionOrder.values,
            title: "Recurring Transactions:",
            scrollController: _scrollController,
            onOrderChanged: changeOrder,
            sortingOrder:
                context.select((DataModel data) => data.recurringOrder),
            onFilterChanged: onSearchFieldChanged,
          ),
          Expanded(
            child: RecurringTransactionList(
              transactions: context
                  .select((DataModel data) => data.recurringTransactions)
                  .where((t) => transactionIncludedInSearchResults(t)),
              selectedTransactions: selectedTransactions,
              transactionOrder:
                  context.select((DataModel data) => data.recurringOrder),
              deleteTransactions: deleteTransactions,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
