import 'package:flutter/material.dart';

class BudgeteeroDrawer extends StatelessWidget {
  static final drawerRoutes = {
    "Balance": "/",
    "Month": "/month",
    "Future Transactions": "/future",
    "Recurring Transactions": "/recurring",
  };

  const BudgeteeroDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 56,
          ),
          const SizedBox(height: 8),
          ...drawerRoutes.entries.map((route) {
            final bool routeIsActive =
                ModalRoute.of(context)!.settings.name == route.value;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: routeIsActive
                        ? Theme.of(context).primaryColor.withOpacity(0.2)
                        : Theme.of(context).drawerTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10)),
                onPressed: () {
                  Navigator.pushNamed(context, route.value);
                },
                child: Text(route.key,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal)),
              ),
            );
          })
        ],
      ),
    );
  }
}
