import '../models/transaction.dart';
import '../widgets/layout/list_title_bar.dart';

enum TransactionOrder implements SortingType<Transaction> {
  dateDescending('Date (Desc)'),
  dateAscending('Date (Asc)'),
  amountDescending('Amount (Desc)'),
  amountAscending('Amount (Asc)'),
  description('Description'),
  payee('Payee');

  @override
  final String label;

  const TransactionOrder(this.label);

  @override
  Comparator<Transaction> getSortingComparator() {
    switch (this) {
      case TransactionOrder.dateAscending:
        return (a, b) => a.date.compareTo(b.date);
      case TransactionOrder.amountAscending:
        return (a, b) => a.amount.abs().compareTo(b.amount.abs());
      case TransactionOrder.amountDescending:
        return (a, b) => b.amount.abs().compareTo(a.amount.abs());
      case TransactionOrder.description:
        return (a, b) => a.description.compareTo(b.description);
      case TransactionOrder.payee:
        return (a, b) => a.transactionPartner.compareTo(b.transactionPartner);
      case TransactionOrder.dateDescending:
      default:
        return (a, b) => b.date.compareTo(a.date);
    }
  }
}