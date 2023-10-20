import 'package:budgeteero/widgets/layout/list_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/persistence_enums.dart';
import '../enums/transaction_order.dart';
import '../models/transaction.dart';
import '../state/data_model.dart';
import '../state/settings_model.dart';
import '../util/utils.dart';
import '../widgets/layout/page_layout.dart';
import '../widgets/layout/transaction_list.dart';
import 'modal/create_transaction_dialog.dart';

class FutureTransactionsScreen extends StatefulWidget {
  final String title;

  const FutureTransactionsScreen({super.key, required this.title});

  @override
  State<FutureTransactionsScreen> createState() =>
      _FutureTransactionsScreenState();
}

class _FutureTransactionsScreenState extends State<FutureTransactionsScreen> {
  final List<Transaction> selectedTransactions = <Transaction>[];
  final ScrollController _scrollController = ScrollController();
  List<String> _searchStrings = [];

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void openCreateFutureTransactionDialog(BuildContext context) {
    setState(() => selectedTransactions.clear());
    final DataModel data = context.read<DataModel>();

    showDialog<Transaction>(
      context: context,
      builder: (BuildContext context) => CreateTransactionDialog(
          earliestDate: Utils.dateOnlyUTC(DateTime.timestamp())
              .add(const Duration(days: 1))),
    ).then((result) {
      if (result != null) {
        data.addTransaction(result);
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

  bool transactionIncludedInSearchResults(Transaction transaction) {
    return _searchStrings.isEmpty ||
        _searchStrings.any((string) => transaction.containsString(string));
  }

  void deleteTransactions(List<Transaction> transactions) {
    DataModel data = context.read<DataModel>();

    data.removeTransactions(transactions);
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

  void changeOrder(TransactionOrder order) {
    context.read<DataModel>().setBalanceOrder(order);
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
                  width: 240,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        {openCreateFutureTransactionDialog(context)},
                    icon: const Icon(Icons.add_circle_sharp),
                    label: const Text('Add Future Transaction'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black12),
          const SizedBox(height: 10),
          ListTitleBar<TransactionOrder>(
            enumValues: TransactionOrder.values,
            title: "Future Transactions:",
            scrollController: _scrollController,
            onOrderChanged: changeOrder,
            sortingOrder: context.select((DataModel data) => data.futureOrder),
            onFilterChanged: onSearchFieldChanged,
          ),
          Expanded(
            child: TransactionList(
              transactions: context
                  .select((DataModel data) => data.futureTransactions)
                  .where((t) => transactionIncludedInSearchResults(t)),
              selectedTransactions: selectedTransactions,
              transactionOrder:
                  context.select((DataModel data) => data.futureOrder),
              deleteTransactions: deleteTransactions,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
