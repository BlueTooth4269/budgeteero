import 'package:budgeteero/widgets/generic/expandable_container.dart';
import 'package:budgeteero/widgets/generic/month_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/persistence_enums.dart';
import '../enums/transaction_order.dart';
import '../models/transaction.dart';
import '../state/data_model.dart';
import '../state/settings_model.dart';
import '../widgets/layout/amount_display.dart';
import '../widgets/layout/list_title_bar.dart';
import '../widgets/layout/page_layout.dart';
import '../widgets/layout/transaction_list.dart';

class MonthScreen extends StatefulWidget {
  final String title;

  const MonthScreen({super.key, required this.title});

  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  DateTime _monthAndYear =
      DateTime.utc(DateTime.timestamp().year, DateTime.timestamp().month);
  final List<Transaction> selectedTransactions = <Transaction>[];
  final ScrollController _scrollController = ScrollController();
  List<String> _searchStrings = [];

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
    context.read<DataModel>().setMonthOrder(order);
    _scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return PageLayoutFrame(
      title: widget.title,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: MonthPicker(
              monthAndYear: _monthAndYear,
              setMonthAndYear: (dt) => setState(() => _monthAndYear = dt),
            ),
          ),
          const Divider(color: Colors.black12),
          Container(
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
                          balance:
                              context.select((DataModel data) => data.balance)),
                      AmountDisplay(
                        title: 'Lowest Balance',
                        balance: context.select((DataModel data) =>
                            data.getLowestBalanceInMonth(_monthAndYear)),
                        alignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ExpandableContainer(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AmountDisplay(
                            title: 'Monthly net',
                            balance: context.select((DataModel data) =>
                                data.getMonthlyNet(_monthAndYear)),
                          ),
                          AmountDisplay(
                            title: 'Outstanding',
                            balance: context.select((DataModel data) => data
                                .getOutstandingBalanceForMonth(_monthAndYear)),
                            alignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AmountDisplay(
                            title: 'Balance at start of month',
                            balance: context.select((DataModel data) =>
                                data.getBalanceAtStartOfMonth(_monthAndYear)),
                          ),
                          AmountDisplay(
                            title: 'Balance at end of month',
                            balance: context.select((DataModel data) =>
                                data.getBalanceAtEndOfMonth(_monthAndYear)),
                            alignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          ListTitleBar<TransactionOrder>(
            enumValues: TransactionOrder.values,
            title: "Transactions:",
            scrollController: _scrollController,
            onOrderChanged: changeOrder,
            sortingOrder: context.select((DataModel data) => data.monthOrder),
            onFilterChanged: onSearchFieldChanged,
          ),
          Expanded(
            child: TransactionList(
              transactions: context
                  .select((DataModel data) =>
                      data.getTransactionsForMonth(_monthAndYear))
                  .where((t) => transactionIncludedInSearchResults(t)),
              selectedTransactions: selectedTransactions,
              transactionOrder:
                  context.select((DataModel data) => data.monthOrder),
              deleteTransactions: deleteTransactions,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
