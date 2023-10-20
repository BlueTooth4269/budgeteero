import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  final List<Widget> children;

  const ExpandableContainer({super.key, required this.children});

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _isExpanded = false;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tooltip(
          message: 'Toggle additional details',
          waitDuration: const Duration(milliseconds: 500),
          child: Container(
            color: _isHovering
                ? Theme.of(context).hoverColor
                : Theme.of(context).colorScheme.background,
            child: GestureDetector(
              onTapDown: (_) => setState(() => _isExpanded = !_isExpanded),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Icon(_isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                          color: Theme.of(context).colorScheme.primary),
                      Text(
                        _isExpanded ? 'Hide' : 'Show more',
                        style:
                            TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 10),
          ...widget.children,
        ],
      ],
    );
  }
}
