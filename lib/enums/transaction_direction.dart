import 'enum_with_label.dart';

enum TransactionDirection implements EnumWithLabel {
  outgoing('Outgoing'), incoming('Incoming');

  @override
  final String label;

  const TransactionDirection(this.label);
}