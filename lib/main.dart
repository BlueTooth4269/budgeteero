import 'package:budgeteero/screens/future_transactions_screen.dart';
import 'package:budgeteero/screens/recurring_transactions_screen.dart';
import 'package:budgeteero/state/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/balance_screen.dart';
import 'screens/month_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DataModel(),
        child: MaterialApp(
          title: 'Budgeteero',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          routes: {
            '/': (context) => const BalanceScreen(title: 'Balance'),
            '/month': (context) => const MonthScreen(title: 'Month'),
            '/future': (context) =>
                const FutureTransactionsScreen(title: 'Future Transactions'),
            '/recurring': (context) => const RecurringTransactionsScreen(
                title: 'Recurring Transactions')
          },
        ));
  }
}
