import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:budgeteero/screens/modal/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../enums/recurring_transaction_order.dart';

class RecurringTransactionList extends StatefulWidget {
  final List<RecurringTransaction> transactions;
  final List<RecurringTransaction> selectedTransactions;
  final RecurringTransactionOrder transactionOrder;
  final void Function(List<RecurringTransaction> transactions)
      deleteTransactions;
  final ScrollController scrollController;

  RecurringTransactionList(
      {super.key,
      required transactions,
      List<RecurringTransaction>? selectedTransactions,
      required this.transactionOrder,
      void Function(List<RecurringTransaction> transactions)?
          deleteTransactions,
      ScrollController? scrollController})
      : transactions = List.from(transactions),
        selectedTransactions = selectedTransactions ?? <RecurringTransaction>[],
        deleteTransactions = deleteTransactions ?? ((transactions) {}),
        scrollController = scrollController ?? ScrollController();

  @override
  State<RecurringTransactionList> createState() =>
      _RecurringTransactionListState();
}

class _RecurringTransactionListState extends State<RecurringTransactionList> {
  void onTilePrimary(RecurringTransaction transaction) {
    if (widget.selectedTransactions.isNotEmpty) {
      if (widget.selectedTransactions.contains(transaction)) {
        setState(() => widget.selectedTransactions.remove(transaction));
      } else {
        setState(() => widget.selectedTransactions.add(transaction));
      }
    }
  }

  void onTileSecondary(RecurringTransaction transaction) {
    if (widget.selectedTransactions.isEmpty) {
      setState(() => widget.selectedTransactions.add(transaction));
    }
  }

  void clearSelection() {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) =>
          const ConfirmationDialog(caption: 'Clear selection?'),
    ).then((confirmed) {
      if (confirmed == true) {
        setState(() => widget.selectedTransactions.clear());
      }
    });
  }

  void deleteSelection(context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const ConfirmationDialog(
          caption: 'Delete selected recurring transactions?',
          subCaption: 'All individual transactions created in this way will also be removed.'),
    ).then((confirmed) {
      if (confirmed == true) {
        widget.deleteTransactions(widget.selectedTransactions);
        setState(() {
          widget.selectedTransactions.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.transactions.sort(widget.transactionOrder.getSortingComparator());

    return Column(
      children: [
        Visibility(
          visible: widget.selectedTransactions.isNotEmpty,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              child: Center(
                child: Container(
                  key: const Key('tileContainer'),
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.withAlpha(150)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                              text:
                                  '${widget.selectedTransactions.length} ${widget.selectedTransactions.length > 1 ? 'transactions' : 'transaction'} selected',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white)),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Tooltip(
                        message: 'Clear selection',
                        child: InkWell(
                          hoverColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(50),
                          onTap: clearSelection,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                shape: BoxShape.rectangle),
                            child: const Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'Delete selection',
                        child: InkWell(
                          hoverColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(50),
                          onTap: () => deleteSelection(context),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                shape: BoxShape.rectangle),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
        Expanded(
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < widget.transactions.length) {
                      return RecurringTransactionTile(
                        widget.transactions[index],
                        onPrimary: onTilePrimary,
                        onSecondary: onTileSecondary,
                        selected: widget.selectedTransactions
                            .contains(widget.transactions[index]),
                      );
                    }
                    return null;
                  },
                  childCount: widget.transactions
                      .length, // Replace with your actual data length
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecurringTransactionTile extends StatelessWidget {
  final RecurringTransaction transaction;
  final void Function(RecurringTransaction) onPrimary;
  final void Function(RecurringTransaction) onSecondary;
  final bool selected;

  RecurringTransactionTile(this.transaction,
      {super.key,
      Function(RecurringTransaction)? onPrimary,
      Function(RecurringTransaction)? onSecondary,
      bool? selected})
      : onPrimary = onPrimary ?? ((_) {}),
        onSecondary = onSecondary ?? ((_) {}),
        selected = selected ?? false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: Center(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTapDown: (_) => onPrimary(transaction),
            onLongPress: () => onSecondary(transaction),
            onSecondaryTapDown: (_) => onSecondary(transaction),
            child: Container(
              key: const Key('tileContainer'),
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withAlpha(selected ? 160 : 20)),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          text: '${transaction.description}\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: selected
                                ? Colors.white
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                          children: [
                            TextSpan(
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 13),
                              text: '${transaction.transactionPartner}\n',
                            ),
                            TextSpan(
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 13),
                              text:
                                  'From: ${intl.DateFormat('dd.MM.yyyy').format(transaction.startDate)}',
                            ),
                          ]),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text:
                          '${intl.NumberFormat.currency(symbol: '€').format(transaction.amount)}\n',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? Colors.white
                            : transaction.amount.isNegative
                                ? Colors.red.withOpacity(0.8)
                                : Colors.lightGreen,
                      ),
                      children: [
                        TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: selected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onBackground),
                          text: '${transaction.intervalType.label}\n',
                        ),
                        TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: selected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onBackground),
                          text: transaction.endingString,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
