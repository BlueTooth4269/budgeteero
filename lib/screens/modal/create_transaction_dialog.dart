import 'package:budgeteero/enums/transaction_direction.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/transaction.dart';
import '../../util/constants.dart';
import '../../util/date_input_formatter.dart';
import '../../util/utils.dart';
import '../../widgets/generic/custom_checkbox.dart';

class CreateTransactionDialog extends StatefulWidget {
  final DateTime earliestDate;
  final DateTime latestDate;

  CreateTransactionDialog(
      {super.key, DateTime? earliestDate, DateTime? latestDate})
      : earliestDate = earliestDate ?? Constants.earliestDate,
        latestDate = latestDate ?? Constants.latestDate;

  @override
  State<CreateTransactionDialog> createState() =>
      _CreateTransactionDialogState();
}

class _CreateTransactionDialogState extends State<CreateTransactionDialog> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transactionPartnerController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _dateKey = GlobalKey<FormFieldState>();
  TransactionDirection selectedDirection = TransactionDirection.outgoing;

  @override
  void initState() {
    super.initState();
    _dateController.text = intl.DateFormat("dd.MM.yyyy").format(
        Utils.dateOnlyUTC(DateTime.timestamp()).isBefore(widget.earliestDate)
            ? widget.earliestDate
            : Utils.dateOnlyUTC(DateTime.timestamp()));
    _dateFocusNode.addListener(() {
      if (_dateFocusNode.hasFocus) {
        _dateController.selection = TextSelection(
            baseOffset: 0, extentOffset: _dateController.text.length);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _transactionPartnerController.dispose();
    _dateController.dispose();
    _descriptionFocusNode.dispose();
    _dateFocusNode.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      double amount = double.parse(_amountController.text.replaceAll(',', ''));

      Navigator.pop(
          context,
          Transaction.createNew(
              selectedDirection == TransactionDirection.outgoing
                  ? -amount
                  : amount,
              _descriptionController.text,
              _transactionPartnerController.text,
              Utils.dateOnlyUTC(
                  intl.DateFormat("dd.MM.yyyy").parse(_dateController.text, true))));
    } else {
      _descriptionFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: const Text('Create Transaction', style: TextStyle(fontSize: 20)),
      content: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: Form(
          onWillPop: () async => true,
          key: _formKey,
          child: ListView(
            children: [
              CustomCheckbox(
                enumValues: TransactionDirection.values,
                initialValue: TransactionDirection.outgoing,
                onSelectionChange: (direction) =>
                    setState(() => selectedDirection = direction),
                unselectedBorderColor: Theme.of(context).dividerColor,
                unselectedColor: Theme.of(context).colorScheme.primary,
                unselectedBackgroundColor:
                    Theme.of(context).colorScheme.background,
                selectedColor: Colors.white,
                selectedBackgroundColor: Theme.of(context).colorScheme.primary,
                hoveredBackgroundColor:
                    Theme.of(context).colorScheme.primary.withAlpha(12),
                onEscapePressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.description_outlined),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  hintText: 'Description',
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor.withAlpha(100)),
                ),
                onFieldSubmitted: (_) => submitForm(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value.replaceAll(',', '')) == null) {
                    return 'Please enter an amount';
                  } else if (double.parse(value.replaceAll(',', '')) == 0) {
                    return 'Transaction amount may not be 0';
                  }
                  return null;
                },
                inputFormatters: [
                  CurrencyTextInputFormatter(symbol: '', enableNegative: false)
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.euro_outlined),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  hintText: 'Amount',
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor.withAlpha(100)),
                ),
                onFieldSubmitted: (_) => submitForm(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _transactionPartnerController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ${selectedDirection == TransactionDirection.outgoing ? 'payee' : 'sender'}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  hintText: selectedDirection == TransactionDirection.outgoing
                      ? 'Payee'
                      : 'Sender',
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor.withAlpha(100)),
                ),
                onFieldSubmitted: (_) => submitForm(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: _dateKey,
                controller: _dateController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  DateTime dt;
                  try {
                    dt = intl.DateFormat('dd.MM.yyyy').parseStrict(value, true);
                    if (dt.isBefore(widget.earliestDate)) {
                      return 'Date must be after ${intl.DateFormat('dd.MM.yyyy').format(widget.earliestDate.subtract(const Duration(days: 1)))}';
                    }
                    if (dt.isAfter(widget.latestDate)) {
                      return 'Date must be before ${intl.DateFormat('dd.MM.yyyy').format(widget.latestDate.add(const Duration(days: 1)))}';
                    }
                  } catch (e) {
                    return 'Date is not valid';
                  }
                  return null;
                },
                inputFormatters: [DateInputFormatter()],
                focusNode: _dateFocusNode,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    context: context,
                    initialDate: Utils.dateOnlyUTC(DateTime.timestamp())
                            .isBefore(widget.earliestDate)
                        ? widget.earliestDate
                        : Utils.dateOnlyUTC(DateTime.timestamp()),
                    firstDate: widget.earliestDate,
                    lastDate: widget.latestDate,
                  );

                  if (pickedDate != null) {
                    setState(() => _dateController.text =
                        intl.DateFormat('dd.MM.yyyy').format(pickedDate));
                    _dateKey.currentState!.validate();
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range_outlined),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  hintText: 'Date',
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor.withAlpha(100)),
                ),
                onFieldSubmitted: (_) => submitForm(),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Directionality(
            textDirection: TextDirection.rtl,
            child: Row(children: [
              TextButton(
                onPressed: () => submitForm(),
                child: const Text('Submit'),
              ),
              const SizedBox(width: 5),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ]))
      ],
    );
  }
}
