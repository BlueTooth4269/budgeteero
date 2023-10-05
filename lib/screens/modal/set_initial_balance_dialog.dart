import 'package:budgeteero/models/initial_balance.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../util/constants.dart';
import '../../util/date_input_formatter.dart';
import '../../util/utils.dart';

class SetInitialBalanceDialog extends StatefulWidget {
  final InitialBalance initialBalance;
  final DateTime? latestDate;

  const SetInitialBalanceDialog(
      {super.key, required this.initialBalance, this.latestDate});

  @override
  State<SetInitialBalanceDialog> createState() =>
      _SetInitialBalanceDialogState();
}

class _SetInitialBalanceDialogState extends State<SetInitialBalanceDialog> {
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final FocusNode _balanceFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _balanceController.text =
        CurrencyTextInputFormatter(symbol: '', decimalDigits: 2)
            .formatDouble(widget.initialBalance.balance);
    _startDateController.text =
        intl.DateFormat("dd.MM.yyyy").format(widget.initialBalance.startDate);
  }

  @override
  void dispose() {
    super.dispose();
    _balanceController.dispose();
    _startDateController.dispose();
    _dateFocusNode.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
          context,
          InitialBalance(
              double.parse(_balanceController.text.replaceAll(',', '')),
              Utils.dateOnlyUTC(intl.DateFormat("dd.MM.yyyy")
                  .parse(_startDateController.text, true))));
    } else {
      _balanceFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: const Text('Set Initial Balance', style: TextStyle(fontSize: 20)),
      content: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                autofocus: true,
                controller: _balanceController,
                focusNode: _balanceFocusNode,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value.replaceAll(',', '')) == null) {
                    return 'Please enter an initial balance';
                  }
                  return null;
                },
                inputFormatters: [CurrencyTextInputFormatter(symbol: '')],
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
                controller: _startDateController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  DateTime dt;
                  try {
                    dt = intl.DateFormat('dd.MM.yyyy').parseStrict(value, true);
                    if (widget.latestDate != null &&
                        widget.latestDate!.isBefore(dt)) {
                      return 'Date cannot be set to after existing transactions';
                    }
                    if (dt.isBefore(Constants.earliestDate)) {
                      return 'Date cannot be before ${intl.DateFormat("dd.MM.yyyy").format(Constants.earliestDate)}';
                    }
                    if (dt.isAfter(Utils.dateOnlyUTC(DateTime.timestamp()))) {
                      return 'Date cannot be in the future';
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
                    initialDate:
                        widget.latestDate ?? Utils.dateOnlyUTC(DateTime.timestamp()),
                    firstDate: Constants.earliestDate,
                    lastDate:
                        widget.latestDate ?? Utils.dateOnlyUTC(DateTime.timestamp()),
                  );

                  if (pickedDate != null) {
                    setState(() => _startDateController.text =
                        intl.DateFormat('dd.MM.yyyy').format(pickedDate));
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
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ]))
      ],
    );
  }
}
