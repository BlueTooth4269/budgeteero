import 'package:budgeteero/screens/balance_screen.dart';
import 'package:budgeteero/screens/future_transactions_screen.dart';
import 'package:budgeteero/screens/recurring_transactions_screen.dart';
import 'package:budgeteero/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../screens/month_screen.dart';

class Route {
  final String url;
  final String name;
  final WidgetBuilder builder;

  Route({required this.name, required this.url, required this.builder});
}

class Routes {
  static final List<Route> routes = [
    Route(
        url: '/',
        name: 'Balance',
        builder: (context) => const BalanceScreen(title: 'Balance')),
    Route(
        url: '/month',
        name: 'Month',
        builder: (context) => const MonthScreen(title: 'Month')),
    Route(
        url: '/future',
        name: 'Future Transactions',
        builder: (context) =>
            const FutureTransactionsScreen(title: 'Future Transactions')),
    Route(
        url: '/recurring',
        name: 'Recurring Transactions',
        builder: (context) =>
            const RecurringTransactionsScreen(title: 'Recurring Transactions')),
    Route(
        url: '/settings',
        name: 'Settings',
        builder: (context) => const SettingsScreen(title: 'Settings')),
  ];

  static final Map<String, WidgetBuilder> routingTable = {
    for (Route route in Routes.routes) route.url: route.builder
  };

  static final Map<String, String> drawerRoutes = {
    for (Route route in Routes.routes) route.name: route.url
  };
}
