import 'package:budgeteero/screens/modal/confirmation_dialog.dart';
import 'package:budgeteero/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../enums/transaction_order.dart';
import '../../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final List<Transaction> selectedTransactions;
  final TransactionOrder transactionOrder;
  final void Function(List<Transaction> transactions) deleteTransactions;
  final ScrollController scrollController;

  TransactionList(
      {super.key,
      required transactions,
      List<Transaction>? selectedTransactions,
      required this.transactionOrder,
      void Function(List<Transaction> transactions)? deleteTransactions,
      ScrollController? scrollController})
      : transactions = List.from(transactions),
        selectedTransactions = selectedTransactions ?? <Transaction>[],
        deleteTransactions = deleteTransactions ?? ((transactions) {}),
        scrollController = scrollController ?? ScrollController();

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  int _displayedTransactionsCount = 50;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      if (_displayedTransactionsCount < widget.transactions.length) {
        setState(() {
          _displayedTransactionsCount += 3;
        });
      }
    }
  }

  void onTilePrimary(Transaction transaction) {
    if (widget.selectedTransactions.isNotEmpty) {
      if (widget.selectedTransactions.contains(transaction)) {
        setState(() => widget.selectedTransactions.remove(transaction));
      } else {
        setState(() => widget.selectedTransactions.add(transaction));
      }
    }
  }

  void onTileSecondary(Transaction transaction) {
    if (widget.selectedTransactions.isEmpty) {
      setState(() => widget.selectedTransactions.add(transaction));
    }
  }

  void clearSelection() {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) =>
          const ConfirmationDialog(message: 'Clear selection?'),
    ).then((confirmed) {
      if (confirmed == true) {
        setState(() => widget.selectedTransactions.clear());
      }
    });
  }

  void deleteSelection(context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) =>
          const ConfirmationDialog(message: 'Delete selected transactions?'),
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
                    if (index < widget.transactions.length &&
                        index < _displayedTransactionsCount) {
                      return TransactionTile(
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

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final void Function(Transaction) onPrimary;
  final void Function(Transaction) onSecondary;
  final bool selected;

  TransactionTile(this.transaction,
      {super.key,
      Function(Transaction)? onPrimary,
      Function(Transaction)? onSecondary,
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
                color: selected
                    ? Theme.of(context).colorScheme.primary.withAlpha(160)
                    : Theme.of(context).colorScheme.primary.withAlpha(
                        transaction.date
                                .isAfter(Utils.dateOnlyUTC(DateTime.timestamp()))
                            ? 15
                            : 20),
              ),
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
                                : Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withAlpha(transaction.date.isAfter(
                                            Utils.dateOnlyUTC(
                                                DateTime.timestamp()))
                                        ? 100
                                        : 255),
                          ),
                          children: [
                            TextSpan(
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 13),
                              text: transaction.transactionPartner,
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
                                ? Colors.red.withOpacity(transaction.date
                                        .isAfter(Utils.dateOnlyUTC(
                                            DateTime.timestamp()))
                                    ? 0.6
                                    : 0.8)
                                : Colors.lightGreen.withOpacity(transaction.date
                                        .isAfter(Utils.dateOnlyUTC(
                                            DateTime.timestamp()))
                                    ? 0.7
                                    : 1),
                      ),
                      children: [
                        TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 13,
                              color: selected
                                  ? Colors.white
                                  : Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withAlpha(transaction.date.isAfter(
                                              Utils.dateOnlyUTC(
                                                  DateTime.timestamp()))
                                          ? 140
                                          : 255)),
                          text: intl.DateFormat('dd/MM/yyyy')
                              .format(transaction.date),
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
