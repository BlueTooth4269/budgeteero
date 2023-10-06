import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final String caption;
  final String? subCaption;

  const ConfirmationDialog({super.key, required this.caption, this.subCaption});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(widget.caption, style: const TextStyle(fontSize: 20)),
      content: widget.subCaption != null
          ? Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(widget.subCaption!),
          )
          : const SizedBox(),
      actions: <Widget>[
        Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              child: Row(children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  autofocus: true,
                  child: const Text('OK'),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
              ]),
            ))
      ],
    );
  }
}
