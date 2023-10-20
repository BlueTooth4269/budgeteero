import 'package:budgeteero/enums/persistence_enums.dart';
import 'package:budgeteero/screens/modal/set_initial_balance_dialog.dart';
import 'package:budgeteero/state/settings_model.dart';
import 'package:budgeteero/widgets/layout/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/transaction_order.dart';
import '../models/initial_balance.dart';
import '../models/transaction.dart';
import '../state/data_model.dart';
import '../util/utils.dart';
import '../widgets/layout/amount_display.dart';
import '../widgets/layout/list_title_bar.dart';
import '../widgets/layout/transaction_list.dart';
import 'modal/create_transaction_dialog.dart';

class BalanceScreen extends StatefulWidget {
  final String title;

  const BalanceScreen({super.key, required this.title});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final List<Transaction> selectedTransactions = <Transaction>[];
  final ScrollController _scrollController = ScrollController();
  List<String> _searchStrings = [];

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void openCreateTransactionDialog(BuildContext context) {
    setState(() => selectedTransactions.clear());
    final DataModel data = context.read<DataModel>();

    showDialog<Transaction>(
      context: context,
      builder: (BuildContext context) => CreateTransactionDialog(
          earliestDate: data.initialBalance.startDate,
          latestDate: Utils.dateOnlyUTC(DateTime.timestamp())),
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

  void openSetInitialBalanceDialog(BuildContext context) {
    setState(() => selectedTransactions.clear());
    final DataModel data = context.read<DataModel>();

    showDialog<InitialBalance>(
      context: context,
      builder: (BuildContext context) => SetInitialBalanceDialog(
          initialBalance: data.initialBalance,
          latestDate: data.getEarliestTransactionDate()),
    ).then((result) {
      if (result != null) {
        data.setInitialBalance(result);
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
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () => {openCreateTransactionDialog(context)},
                    icon: const Icon(Icons.add_circle_sharp),
                    label: const Text('Add Transaction'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () => {openSetInitialBalanceDialog(context)},
                    icon: const Icon(Icons.attach_money),
                    label: const Text('Set initial balance'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black12),
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 10),
            child: AmountDisplay(
                balance: context.select((DataModel data) => data.balance)),
          ),
          ListTitleBar<TransactionOrder>(
            enumValues: TransactionOrder.values,
            title: "Transactions:",
            scrollController: _scrollController,
            onOrderChanged: changeOrder,
            sortingOrder: context.select((DataModel data) => data.balanceOrder),
            onFilterChanged: onSearchFieldChanged,
          ),
          Expanded(
              child: TransactionList(
            transactions: context
                .select((DataModel data) => data.pastTransactions)
                .where((t) => transactionIncludedInSearchResults(t)),
            selectedTransactions: selectedTransactions,
            transactionOrder:
                context.select((DataModel data) => data.balanceOrder),
            deleteTransactions: deleteTransactions,
            scrollController: _scrollController,
          )),
        ],
      ),
    );
  }
}
