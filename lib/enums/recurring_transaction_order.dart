import 'package:budgeteero/models/recurring_transaction.dart';

import '../widgets/generic/sorting_dropdown.dart';

enum RecurringTransactionOrder implements SortingDropdownEnum<RecurringTransaction> {
  startDateDescending('Start Date (Desc)'),
  startDateAscending('Start Date (Asc)'),
  amountDescending('Amount (Desc)'),
  amountAscending('Amount (Asc)'),
  description('Description'),
  payee('Payee');

  @override
  final String label;

  const RecurringTransactionOrder(this.label);

  @override
  Comparator<RecurringTransaction> getSortingComparator() {
    switch (this) {
      case RecurringTransactionOrder.startDateAscending:
        return (a, b) => a.startDate.compareTo(b.startDate);
      case RecurringTransactionOrder.amountAscending:
        return (a, b) => a.amount.abs().compareTo(b.amount.abs());
      case RecurringTransactionOrder.amountDescending:
        return (a, b) => b.amount.abs().compareTo(a.amount.abs());
      case RecurringTransactionOrder.description:
        return (a, b) => a.description.compareTo(b.description);
      case RecurringTransactionOrder.payee:
        return (a, b) => a.transactionPartner.compareTo(b.transactionPartner);
      case RecurringTransactionOrder.startDateDescending:
      default:
        return (a, b) => b.startDate.compareTo(a.startDate);
    }
  }
}