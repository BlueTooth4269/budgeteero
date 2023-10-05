import 'package:budgeteero/widgets/generic/month_picker.dart';
import 'package:budgeteero/widgets/layout/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/transaction_order.dart';
import '../models/transaction.dart';
import '../state/data_model.dart';
import '../widgets/generic/sorting_dropdown.dart';
import '../widgets/layout/amount_display.dart';
import '../widgets/layout/transaction_list.dart';

class MonthScreen extends StatefulWidget {
  final String title;

  const MonthScreen({super.key, required this.title});

  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  DateTime _monthAndYear = DateTime.utc(DateTime.timestamp().year, DateTime.timestamp().month);
  final ScrollController _scrollController = ScrollController();

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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: MonthPicker(
                monthAndYear: _monthAndYear,
                setMonthAndYear: (dt) => setState(() => _monthAndYear = dt),
              ),
            ),
            const Divider(color: Colors.black12),
            Consumer<DataModel>(
              builder: (context, dataModel, child) => Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(50, 5, 50, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AmountDisplay(
                              title: 'Current balance',
                              balance: dataModel.balance),
                          AmountDisplay(
                            title: 'Outstanding',
                            balance: dataModel
                                .getOutstandingBalanceForMonth(_monthAndYear),
                            alignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AmountDisplay(
                            title: 'Balance at end of month',
                            balance:
                                dataModel.getBalanceAtEndOfMonth(_monthAndYear),
                          ),
                          AmountDisplay(
                            title: 'Monthly net',
                            balance: dataModel.getMonthlyNet(_monthAndYear),
                            alignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AmountDisplay(
                            title: 'Lowest Balance',
                            balance:
                            dataModel.getLowestBalanceInMonth(_monthAndYear),
                          ),
                        ],
                      ),
                    ],
                  )),
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
                            dataModel.monthOrder = order;
                            _scrollController.jumpTo(0);
                          },
                          sortingOrder: dataModel.monthOrder,
                          enumValues: TransactionOrder.values);
                    }
                  }),
                ],
              ),
            ),
            Expanded(
              child: Consumer<DataModel>(builder: (context, dataModel, child) {
                return TransactionList(
                  transactions:
                      dataModel.getTransactionsForMonth(_monthAndYear),
                  transactionOrder: dataModel.monthOrder,
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
    );
  }
}
