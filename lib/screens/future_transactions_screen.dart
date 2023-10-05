import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/transaction_order.dart';
import '../models/transaction.dart';
import '../state/data_model.dart';
import '../util/utils.dart';
import '../widgets/generic/sorting_dropdown.dart';
import '../widgets/layout/drawer.dart';
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
  TransactionOrder futureTransactionOrder = TransactionOrder.dateAscending;
  final ScrollController _scrollController = ScrollController();

  void openCreateFutureTransactionDialog(BuildContext context) {
    final DataModel dataModel = Provider.of<DataModel>(context, listen: false);

    showDialog<Transaction>(
      context: context,
      builder: (BuildContext context) => CreateTransactionDialog(
        earliestDate:
            Utils.dateOnlyUTC(DateTime.timestamp()).add(const Duration(days: 1))
      ),
    ).then((result) {
      if (result != null) {
        setState(() => dataModel.addTransaction(result));
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
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 15.0),
              child: Column(children: [
                SizedBox(
                  width: 240,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        {openCreateFutureTransactionDialog(context)},
                    icon: const Icon(Icons.add_circle_sharp),
                    label: const Text('Add Future Transaction'),
                  ),
                ),
              ]),
            ),
            const Divider(color: Colors.black12),
            const SizedBox(height: 10),
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Future Transactions:',
                      style: TextStyle(fontSize: 16)),
                  Consumer<DataModel>(builder: (context, dataModel, child) {
                    {
                      return SortingDropdown<TransactionOrder>(
                          onOrderChanged: (order) {
                            setState(() => futureTransactionOrder = order);
                            _scrollController.jumpTo(0);
                          },
                          sortingOrder: futureTransactionOrder,
                          enumValues: TransactionOrder.values);
                    }
                  }),
                ],
              ),
            ),
            Expanded(
              child: Consumer<DataModel>(builder: (context, dataModel, child) {
                return TransactionList(
                  transactions: dataModel.futureTransactions,
                  transactionOrder: futureTransactionOrder,
                  deleteTransactions: (List<Transaction> transactions) =>
                      Provider.of<DataModel>(context, listen: false)
                          .removeTransactions(transactions),
                  scrollController: _scrollController,
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
