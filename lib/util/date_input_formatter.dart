import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    final RegExp dateRegExp = RegExp(r'^\d{0,2}(\.\d{0,2}(\.\d{0,4})?)?$');

    if (text.isEmpty) {
      return newValue;
    }

    if (text.length > 10) {
      text = text.substring(0, 10);
    }

    if (!dateRegExp.hasMatch(text)) {
      return oldValue;
    }

    return newValue.copyWith(
      text: text,
      selection:
      TextSelection.collapsed(offset: newValue.selection.extentOffset),
    );
  }
}