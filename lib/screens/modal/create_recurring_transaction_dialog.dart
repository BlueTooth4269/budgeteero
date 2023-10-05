import 'package:budgeteero/enums/recurring_limit.dart';
import 'package:budgeteero/enums/transaction_direction.dart';
import 'package:budgeteero/models/recurring_transaction.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

import '../../enums/interval_type.dart';
import '../../util/constants.dart';
import '../../util/date_input_formatter.dart';
import '../../util/utils.dart';
import '../../widgets/generic/custom_checkbox.dart';

class CreateRecurringTransactionDialog extends StatefulWidget {
  final DateTime earliestDate;
  final DateTime latestDate;

  CreateRecurringTransactionDialog(
      {super.key, DateTime? earliestDate, DateTime? latestDate})
      : earliestDate = earliestDate ?? Constants.earliestDate,
        latestDate = latestDate ?? Constants.latestDate;

  @override
  State<CreateRecurringTransactionDialog> createState() =>
      _CreateRecurringTransactionDialogState();
}

class _CreateRecurringTransactionDialogState
    extends State<CreateRecurringTransactionDialog> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transactionPartnerController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _repetitionsController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _startDateFocusNode = FocusNode();
  final FocusNode _endDateFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _startDateKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _endDateKey = GlobalKey<FormFieldState>();
  TransactionDirection _selectedDirection = TransactionDirection.outgoing;
  IntervalType _selectedInterval = IntervalType.monthly;
  RecurringLimit _recurringLimit = RecurringLimit.indefinite;
  bool _showNoValidationErrors = false;
  bool _startDateIsValid = false;

  @override
  void initState() {
    super.initState();
    _startDateFocusNode.addListener(() {
      if (_startDateFocusNode.hasFocus) {
        _startDateController.selection = TextSelection(
            baseOffset: 0, extentOffset: _startDateController.text.length);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _transactionPartnerController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _repetitionsController.dispose();
    _descriptionFocusNode.dispose();
    _startDateFocusNode.dispose();
    _endDateFocusNode.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      double amount = double.parse(_amountController.text.replaceAll(',', ''));
      RecurringTransaction transaction;
      switch (_recurringLimit) {
        case RecurringLimit.endDate:
          transaction = EndDateLimitedRecurringTransaction.createNew(
              startDate: intl.DateFormat("dd.MM.yyyy")
                  .parse(_startDateController.text, true),
              amount: _selectedDirection == TransactionDirection.outgoing
                  ? -amount
                  : amount,
              intervalType: _selectedInterval,
              description: _descriptionController.text,
              transactionPartner: _transactionPartnerController.text,
              endDate:
                  intl.DateFormat("dd.MM.yyyy").parse(_endDateController.text, true));
          break;
        case RecurringLimit.repetitions:
          transaction = RepetitionLimitedRecurringTransaction.createNew(
              startDate: Utils.dateOnlyUTC(intl.DateFormat("dd.MM.yyyy")
                  .parse(_startDateController.text, true)),
              amount: _selectedDirection == TransactionDirection.outgoing
                  ? -amount
                  : amount,
              intervalType: _selectedInterval,
              description: _descriptionController.text,
              transactionPartner: _transactionPartnerController.text,
              repetitions: int.parse(_repetitionsController.text));
          break;
        case RecurringLimit.indefinite:
        default:
          transaction = RecurringTransaction.createNew(
              startDate: Utils.dateOnlyUTC(intl.DateFormat("dd.MM.yyyy")
                  .parse(_startDateController.text, true)),
              amount: _selectedDirection == TransactionDirection.outgoing
                  ? -amount
                  : amount,
              intervalType: _selectedInterval,
              description: _descriptionController.text,
              transactionPartner: _transactionPartnerController.text);
      }

      if (_recurringLimit == RecurringLimit.indefinite) {
        transaction = RecurringTransaction.createNew(
            startDate:
                intl.DateFormat("dd.MM.yyyy").parse(_startDateController.text, true),
            amount: _selectedDirection == TransactionDirection.outgoing
                ? -amount
                : amount,
            intervalType: _selectedInterval,
            description: _descriptionController.text,
            transactionPartner: _transactionPartnerController.text);
      }

      Navigator.pop(context, transaction);
    } else {
      _descriptionFocusNode.requestFocus();
    }
  }

  void clearValidationErrors() {
    _showNoValidationErrors = true;
    _formKey.currentState!.validate();
    _showNoValidationErrors = false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: const Text('Create Recurring Transaction',
          style: TextStyle(fontSize: 20)),
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
                initialValue: _selectedDirection,
                onSelectionChange: (direction) =>
                    setState(() => _selectedDirection = direction),
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
                controller: _amountController,
                validator: (value) {
                  if (_showNoValidationErrors) return null;
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
                key: _startDateKey,
                controller: _startDateController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_showNoValidationErrors) return null;
                  if (value == null || value.isEmpty) {
                    return 'Please enter a start date';
                  }
                  DateTime dt;
                  try {
                    dt = intl.DateFormat('dd.MM.yyyy').parseStrict(value, true);
                    if (dt.isBefore(widget.earliestDate)) {
                      return 'Date cannot be before ${intl.DateFormat('dd.MM.yyyy').format(widget.earliestDate)}';
                    }
                    if (dt.isAfter(widget.latestDate)) {
                      return 'Date cannot be after ${intl.DateFormat('dd.MM.yyyy').format(widget.latestDate)}';
                    }
                  } catch (e) {
                    return 'Start Date is not valid';
                  }
                  return null;
                },
                inputFormatters: [DateInputFormatter()],
                focusNode: _startDateFocusNode,
                onChanged: (_) => setState(() =>
                    _startDateIsValid = _startDateKey.currentState!.validate()),
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
                    setState(() => _startDateController.text =
                        intl.DateFormat('dd.MM.yyyy').format(pickedDate));
                    setState(() => _startDateIsValid =
                        _startDateKey.currentState!.validate());
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range_outlined),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  hintText: 'Start Date',
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor.withAlpha(100)),
                ),
                onFieldSubmitted: (_) => submitForm(),
              ),
              if (_startDateIsValid) ...[
                const SizedBox(height: 20),
                CustomCheckbox(
                  enumValues: IntervalType.values,
                  initialValue: _selectedInterval,
                  onSelectionChange: (interval) =>
                      setState(() => _selectedInterval = interval),
                  unselectedBorderColor: Theme.of(context).dividerColor,
                  unselectedColor: Theme.of(context).colorScheme.primary,
                  unselectedBackgroundColor:
                      Theme.of(context).colorScheme.background,
                  selectedColor: Colors.white,
                  selectedBackgroundColor:
                      Theme.of(context).colorScheme.primary,
                  hoveredBackgroundColor:
                      Theme.of(context).colorScheme.primary.withAlpha(12),
                  onEscapePressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                CustomCheckbox(
                  enumValues: RecurringLimit.values,
                  initialValue: _recurringLimit,
                  onSelectionChange: (limit) {
                    setState(() => _recurringLimit = limit);
                    clearValidationErrors();
                  },
                  unselectedBorderColor: Theme.of(context).dividerColor,
                  unselectedColor: Theme.of(context).colorScheme.primary,
                  unselectedBackgroundColor:
                      Theme.of(context).colorScheme.background,
                  selectedColor: Colors.white,
                  selectedBackgroundColor:
                      Theme.of(context).colorScheme.primary,
                  hoveredBackgroundColor:
                      Theme.of(context).colorScheme.primary.withAlpha(12),
                  onEscapePressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                if (_recurringLimit == RecurringLimit.endDate)
                  TextFormField(
                    key: _endDateKey,
                    controller: _endDateController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (_showNoValidationErrors) return null;
                      if (value == null || value.isEmpty) {
                        return 'Please enter an end date';
                      }
                      DateTime dt;
                      try {
                        dt = intl.DateFormat('dd.MM.yyyy').parseStrict(value, true);
                        if (dt.isBefore(intl.DateFormat("dd.MM.yyyy")
                            .parse(_startDateController.text, true))) {
                          return 'Date cannot be before start date';
                        }
                        if (dt.isAfter(widget.latestDate)) {
                          return 'Date cannot be after ${intl.DateFormat('dd.MM.yyyy').format(widget.latestDate)}';
                        }
                      } catch (e) {
                        return 'End Date is not valid';
                      }
                      return null;
                    },
                    inputFormatters: [DateInputFormatter()],
                    focusNode: _endDateFocusNode,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        context: context,
                        initialDate: intl.DateFormat("dd.MM.yyyy")
                            .parse(_startDateController.text, true),
                        firstDate: intl.DateFormat("dd.MM.yyyy")
                            .parse(_startDateController.text, true),
                        lastDate: widget.latestDate,
                      );

                      if (pickedDate != null) {
                        setState(() => _endDateController.text =
                            intl.DateFormat('dd.MM.yyyy').format(pickedDate));
                        _endDateKey.currentState!.validate();
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.date_range_outlined),
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      hintText: 'End Date',
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor.withAlpha(100)),
                    ),
                    onFieldSubmitted: (_) => submitForm(),
                  ),
                if (_recurringLimit == RecurringLimit.repetitions)
                  TextFormField(
                    controller: _repetitionsController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (_showNoValidationErrors) return null;
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of repetitions';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a number';
                      }
                      if (int.parse(value) < 1) {
                        return 'Must be 1 or more repetitions';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.repeat),
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      hintText: 'Repetitions',
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor.withAlpha(100)),
                    ),
                    onFieldSubmitted: (_) => submitForm(),
                  ),
                if (_recurringLimit != RecurringLimit.indefinite)
                  const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (_showNoValidationErrors) return null;
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
                  controller: _transactionPartnerController,
                  validator: (value) {
                    if (_showNoValidationErrors) return null;
                    if (value == null || value.isEmpty) {
                      return 'Please enter a ${_selectedDirection == TransactionDirection.outgoing ? 'payee' : 'sender'}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    hintText:
                        _selectedDirection == TransactionDirection.outgoing
                            ? 'Payee'
                            : 'Sender',
                    hintStyle: TextStyle(
                        color: Theme.of(context).hintColor.withAlpha(100)),
                  ),
                  onFieldSubmitted: (_) => submitForm(),
                )
              ],
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
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ]))
      ],
    );
  }
}
