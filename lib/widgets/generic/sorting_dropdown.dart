import 'package:flutter/material.dart';

import '../layout/list_title_bar.dart';

class SortingDropdown<T extends SortingType> extends StatelessWidget {
  final T sortingOrder;
  final void Function(T) onOrderChanged;
  final List<T> enumValues;

  const SortingDropdown({
    super.key,
    required this.sortingOrder,
    required this.onOrderChanged,
    required this.enumValues,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sort By',
      waitDuration: const Duration(milliseconds: 500),
      child: PopupMenuButton<T>(
        tooltip: '',
          elevation: 1,
          itemBuilder: (context) {
            return enumValues.map((enumValue) {
              return PopupMenuItem(
                height: 40,
                value: enumValue,
                child: Text(enumValue.label,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary)),
              );
            }).toList();
          },
          onSelected: onOrderChanged,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 8),
                child: Text(sortingOrder.label,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.primary),
            ],
          )),
    );
  }
}