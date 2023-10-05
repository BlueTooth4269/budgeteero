import 'package:budgeteero/enums/enum_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomCheckbox<T extends EnumWithLabel> extends StatefulWidget {
  final List<T> enumValues;
  final T initialValue;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final Color hoveredBorderColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color hoveredColor;
  final Color unselectedBackgroundColor;
  final Color selectedBackgroundColor;
  final Color hoveredBackgroundColor;
  final void Function(T selectedValue) onSelectionChange;
  final void Function() onEscapePressed;

  CustomCheckbox(
      {super.key,
      required this.enumValues,
      required this.initialValue,
      required this.onSelectionChange,
      required this.unselectedBorderColor,
      required this.unselectedColor,
      required this.unselectedBackgroundColor,
      required this.selectedColor,
      required this.selectedBackgroundColor,
      Color? selectedBorderColor,
      Color? hoveredBorderColor,
      Color? hoveredColor,
      Color? hoveredBackgroundColor,
      void Function()? onEscapePressed})
      : selectedBorderColor = selectedBorderColor ?? selectedBackgroundColor,
        hoveredBorderColor = hoveredBorderColor ?? unselectedBorderColor,
        hoveredColor = hoveredColor ?? unselectedColor,
        hoveredBackgroundColor =
            hoveredBackgroundColor ?? unselectedBackgroundColor,
        onEscapePressed = onEscapePressed ?? (() {});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState<T>();
}

class _CustomCheckboxState<T extends EnumWithLabel>
    extends State<CustomCheckbox<T>> {
  final FocusNode _focusNode = FocusNode();
  int hoveredIndex = -1;
  int selectedIndex = 0;
  bool isFocussed = false;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.enumValues.indexOf(widget.initialValue);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  BoxDecoration getBoxDecorationForIndex(int index) {
    int length = widget.enumValues.length;
    return BoxDecoration(
        color: selectedIndex == index
            ? widget.selectedBackgroundColor
            : hoveredIndex == index
                ? widget.hoveredBackgroundColor
                : widget.unselectedBackgroundColor,
        backgroundBlendMode: BlendMode.darken,
        borderRadius: BorderRadius.horizontal(
            left: index == 0 ? const Radius.elliptical(5, 4) : Radius.zero,
            right: index == length - 1
                ? const Radius.elliptical(5, 4)
                : Radius.zero));
  }

  void handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        widget.onEscapePressed();
      } else if (event.logicalKey == LogicalKeyboardKey.tab) {
        if (event.isShiftPressed) {
          _focusNode.previousFocus();
        } else {
          _focusNode.nextFocus();
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        setState(() {
          selectedIndex =
              (selectedIndex - 1).clamp(0, widget.enumValues.length - 1);
        });
        widget.onSelectionChange(widget.enumValues[selectedIndex]);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        setState(() {
          selectedIndex =
              (selectedIndex + 1).clamp(0, widget.enumValues.length - 1);
        });
        widget.onSelectionChange(widget.enumValues[selectedIndex]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onFocusChange: (focus) => setState(() => isFocussed = focus),
      focusNode: _focusNode,
      onKey: (node, evt) {
        handleKeyPress(evt);
        return KeyEventResult.handled;
      },
      child: Container(
        margin: EdgeInsets.all(isFocussed ? 0 : 1),
        decoration: BoxDecoration(
            border: isFocussed
                ? Border.all(
                    width: 2, color: Theme.of(context).colorScheme.primary)
                : Border.all(width: 1, color: widget.unselectedBorderColor),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(widget.enumValues.length * 2 - 1,
                (index) {
              if (index.isEven) {
                // Even indexes are for containers
                final containerIndex = index ~/ 2;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _focusNode.requestFocus();
                      if (containerIndex != selectedIndex) {
                        setState(() => selectedIndex = containerIndex);
                        widget.onSelectionChange(
                            widget.enumValues[selectedIndex]);
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) {
                        setState(() => hoveredIndex = containerIndex);
                      },
                      onExit: (_) => setState(() => hoveredIndex = -1),
                      child: Container(
                        decoration: getBoxDecorationForIndex(containerIndex),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(13),
                        child: Text(
                          widget.enumValues[containerIndex].label,
                          style: TextStyle(
                              color: selectedIndex == containerIndex
                                  ? widget.selectedColor
                                  : hoveredIndex == containerIndex
                                      ? widget.hoveredColor
                                      : widget.unselectedColor,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Visibility(
                  visible: index == selectedIndex * 2 - 1 ||
                          index == selectedIndex * 2 + 1
                      ? false
                      : true,
                  child: Container(
                      padding: EdgeInsets.zero,
                      height: 46,
                      width: 1,
                      child:
                          VerticalDivider(color: widget.unselectedBorderColor)),
                );
              }
            }).toList()),
      ),
    );
  }
}
