import 'package:budgeteero/screens/modal/set_initial_balance_dialog.dart';
import 'package:budgeteero/widgets/layout/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/transaction_order.dart';
import '../models/initial_balance.dart';
import '../models/transaction.dart';
import '../state/data_model.dart';
import '../util/utils.dart';
import '../widgets/generic/sorting_dropdown.dart';
import '../widgets/layout/amount_display.dart';
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

  void openCreateTransactionDialog(BuildContext context) {
    setState(() => selectedTransactions.clear());
    final DataModel dataModel = Provider.of<DataModel>(context, listen: false);

    showDialog<Transaction>(
      context: context,
      builder: (BuildContext context) => CreateTransactionDialog(
          earliestDate: dataModel.initialBalance.startDate,
          latestDate: Utils.dateOnlyUTC(DateTime.timestamp())),
    ).then((result) {
      if (result != null) {
        setState(() => dataModel.addTransaction(result));
      }
    });
  }

  void openSetInitialBalanceDialog(BuildContext context) {
    setState(() => selectedTransactions.clear());
    final DataModel dataModel = Provider.of<DataModel>(context, listen: false);

    showDialog<InitialBalance>(
      context: context,
      builder: (BuildContext context) => SetInitialBalanceDialog(
          initialBalance: dataModel.initialBalance,
          latestDate: dataModel.getEarliestTransactionDate()),
    ).then((result) {
      if (result != null) {
        setState(() => dataModel.initialBalance = result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(widget.title),
        ),
        drawer: const BudgeteeroDrawer(),
        body: Center(
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
                child: Consumer<DataModel>(
                    builder: (context, dataModel, child) =>
                        AmountDisplay(balance: dataModel.balance)),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Transactions:', style: TextStyle(fontSize: 16)),
                    Consumer<DataModel>(builder: (context, dataModel, child) {
                      {
                        return SortingDropdown<TransactionOrder>(
                            onOrderChanged: (order) {
                              dataModel.transactionOrder = order;
                              _scrollController.jumpTo(0);
                            },
                            sortingOrder: dataModel.transactionOrder,
                            enumValues: TransactionOrder.values);
                      }
                    }),
                  ],
                ),
              ),
              Expanded(
                child:
                    Consumer<DataModel>(builder: (context, dataModel, child) {
                  return TransactionList(
                    transactions: dataModel.pastTransactions,
                    selectedTransactions: selectedTransactions,
                    transactionOrder: dataModel.transactionOrder,
                    deleteTransactions: (List<Transaction> transactions) =>
                        Provider.of<DataModel>(context, listen: false)
                            .removeTransactions(transactions),
                    scrollController: _scrollController,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
