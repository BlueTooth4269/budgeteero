import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AmountDisplay extends StatelessWidget {
  final double balance;
  final String title;
  final CrossAxisAlignment alignment;

  const AmountDisplay(
      {super.key,
      this.title = 'Balance',
      required this.balance,
      this.alignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w100)),
        Text(
          intl.NumberFormat.currency(symbol: '€').format(balance),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: balance.isNegative
                  ? Colors.red.withOpacity(0.8)
                  : Colors.lightGreen),
        )
      ],
    );
  }
}
