import 'dart:math';

import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required bool searchFieldHasFocus,
    required this.titleWidth,
    required FocusNode searchFocusNode,
    required TextEditingController searchFieldController,
    required this.constraints,
  })  : _searchFieldHasFocus = searchFieldHasFocus,
        _searchFocusNode = searchFocusNode,
        _searchFieldController = searchFieldController;

  final bool _searchFieldHasFocus;
  final double titleWidth;
  final FocusNode _searchFocusNode;
  final TextEditingController _searchFieldController;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: _searchFieldHasFocus
          ? min(202, constraints.maxWidth - titleWidth)
          : 40,
      duration: const Duration(milliseconds: 80),
      child: SizedBox(
        height: 44,
        child: TextField(
          focusNode: _searchFocusNode,
          controller: _searchFieldController,
          decoration: InputDecoration(
            fillColor:
                _searchFieldController.text.isNotEmpty && !_searchFieldHasFocus
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
            filled: true,
            prefixIcon: MouseRegion(
                cursor: _searchFieldHasFocus
                    ? MouseCursor.defer
                    : SystemMouseCursors.click,
                child: Icon(
                  _searchFieldController.text.isNotEmpty &&
                          !_searchFieldHasFocus
                      ? Icons.manage_search
                      : Icons.search,
                  color: _searchFieldController.text.isNotEmpty &&
                          !_searchFieldHasFocus
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                )),
            suffixIcon:
                _searchFieldController.text.isNotEmpty && _searchFieldHasFocus
                    ? GestureDetector(
                        onTapDown: (_) {
                          _searchFieldController.clear();
                        },
                        child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Icon(
                              Icons.clear,
                              size: 22,
                              color: Theme.of(context).hintColor,
                            )),
                      )
                    : null,
            contentPadding: const EdgeInsets.all(10),
            border: _searchFieldHasFocus
                ? const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))
                : InputBorder.none,
            hintText: 'Search',
            hintStyle:
                TextStyle(color: Theme.of(context).hintColor.withAlpha(100)),
          ),
        ),
      ),
    );
  }
}
