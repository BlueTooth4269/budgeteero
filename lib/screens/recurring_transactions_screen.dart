import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:budgeteero/screens/modal/create_recurring_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/recurring_transaction_order.dart';
import '../state/data_model.dart';
import '../widgets/generic/sorting_dropdown.dart';
import '../widgets/layout/drawer.dart';
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

  void openCreateRecurringTransactionDialog(BuildContext context) {
    setState(() => selectedTransactions.clear());
    final DataModel dataModel = Provider.of<DataModel>(context, listen: false);

    showDialog<RecurringTransaction>(
      context: context,
      builder: (BuildContext context) => CreateRecurringTransactionDialog(),
    ).then((result) {
      if (result != null) {
        setState(() => dataModel.addRecurringTransaction(result));
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
                  width: 260,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        {openCreateRecurringTransactionDialog(context)},
                    icon: const Icon(Icons.add_circle_sharp),
                    label: const Text('Add Recurring Transaction'),
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
                  const Text('Recurring Transactions:',
                      style: TextStyle(fontSize: 16)),
                  Consumer<DataModel>(builder: (context, dataModel, child) {
                    {
                      return SortingDropdown<RecurringTransactionOrder>(
                          onOrderChanged: (order) {
                            setState(() => dataModel.recurringOrder = order);
                            _scrollController.jumpTo(0);
                          },
                          sortingOrder: dataModel.recurringOrder,
                          enumValues: RecurringTransactionOrder.values);
                    }
                  }),
                ],
              ),
            ),
            Expanded(
              child: Consumer<DataModel>(builder: (context, dataModel, child) {
                return RecurringTransactionList(
                  transactions: dataModel.recurringTransactions,
                  selectedTransactions: selectedTransactions,
                  transactionOrder: dataModel.recurringOrder,
                  deleteTransactions:
                      (List<RecurringTransaction> recurringTransactions) =>
                          Provider.of<DataModel>(context, listen: false)
                              .removeRecurringTransactions(
                                  recurringTransactions),
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
