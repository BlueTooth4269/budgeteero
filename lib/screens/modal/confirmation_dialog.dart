import 'package:flutter/material.dart';


class ConfirmationDialog extends StatefulWidget {
  final String message;

  const ConfirmationDialog(
      {super.key, required this.message});

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
      title: Text(widget.message, style: const TextStyle(fontSize: 20)),
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
