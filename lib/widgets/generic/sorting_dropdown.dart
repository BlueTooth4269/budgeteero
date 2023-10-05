import 'package:flutter/material.dart';

class SortingDropdown<T extends SortingDropdownEnum> extends StatelessWidget {
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
    return PopupMenuButton<T>(
        tooltip: 'Sort By',
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
              padding: const EdgeInsets.all(12.0),
              child: Text(sortingOrder.label,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primary),
          ],
        ));
  }
}

abstract class SortingDropdownEnum<T> implements Enum {
  String get label;
  Comparator<T> getSortingComparator();
}