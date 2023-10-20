
import 'package:budgeteero/widgets/layout/search_field.dart';
import 'package:flutter/material.dart';

import '../generic/sorting_dropdown.dart';

class ListTitleBar<T extends SortingType> extends StatefulWidget {
  final String title;
  final List<T> enumValues;
  final ScrollController scrollController;
  final T sortingOrder;
  final void Function(T) onOrderChanged;
  final void Function(String) onFilterChanged;

  const ListTitleBar(
      {super.key,
      required this.enumValues,
      required this.title,
      required this.scrollController,
      required this.onOrderChanged,
      required this.sortingOrder,
      required this.onFilterChanged});

  @override
  State<ListTitleBar> createState() => _ListTitleBarState<T>();
}

class _ListTitleBarState<T extends SortingType> extends State<ListTitleBar<T>> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchFieldController = TextEditingController();
  bool _searchFieldHasFocus = false;
  double titleWidth = 0;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() => _searchFieldHasFocus = _searchFocusNode.hasFocus);
      _searchFieldController.selection = TextSelection(
          baseOffset: 0, extentOffset: _searchFieldController.text.length);
    });

    _searchFieldController.addListener(() {
      widget.onFilterChanged(_searchFieldController.text);
    });

    TextPainter tp = TextPainter(
        text:
            TextSpan(text: widget.title, style: const TextStyle(fontSize: 16)),
        textDirection: TextDirection.ltr);
    tp.layout();
    titleWidth = tp.width + 15;
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.dispose();
    _searchFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      alignment: Alignment.topLeft,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: const TextStyle(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SortingDropdown<T>(
                        onOrderChanged: widget.onOrderChanged,
                        sortingOrder: widget.sortingOrder,
                        enumValues: widget.enumValues),
                    const SizedBox(width: 50)
                  ],
                ),
              ],
            ),
            SearchField(
              searchFieldHasFocus: _searchFieldHasFocus,
              titleWidth: titleWidth,
              searchFocusNode: _searchFocusNode,
              searchFieldController: _searchFieldController,
              constraints: constraints,
            ),
          ],
        );
      }),
    );
  }
}

abstract class SortingType<T> implements Enum {
  String get label;

  Comparator<T> getSortingComparator();
}
