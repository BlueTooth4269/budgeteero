import 'enum_with_label.dart';

enum RecurringLimit implements EnumWithLabel {
  endDate("End Date"), repetitions("Repetitions"), indefinite("Indefinite");

  @override
  final String label;

  const RecurringLimit(this.label);
}