import 'package:dart_mappable/dart_mappable.dart';

import '../util/custom_date_time_mapper.dart';

part 'initial_balance.mapper.dart';

@MappableClass(includeCustomMappers: [CustomDateTimeMapper()])
class InitialBalance with InitialBalanceMappable {
  double balance;
  DateTime startDate;

  InitialBalance(this.balance, this.startDate);
}
