import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:intl/intl.dart' as intl;

import '../../util/utils.dart';

class MonthPicker extends StatefulWidget {
  final DateTime monthAndYear;
  final Function(DateTime) setMonthAndYear;

  const MonthPicker(
      {super.key, required this.monthAndYear, required this.setMonthAndYear});

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return TapRegion(
        onTapOutside: (evt) => setState(() => _isExpanded = false),
        child: Column(children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
                icon: Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.primary),
                label: Text(
                    intl.DateFormat('MMMM yyyy').format(widget.monthAndYear),
                    style: const TextStyle(fontSize: 22)),
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(10, 15, 5, 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)))),
          ),
          const SizedBox(height: 10),
          Visibility(
              visible: _isExpanded,
              child: dp.MonthPicker.single(
                  datePickerLayoutSettings: const dp.DatePickerLayoutSettings(
                      maxDayPickerRowCount: 5),
                  datePickerStyles: dp.DatePickerStyles(
                      displayedPeriodTitle: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                      selectedSingleDateDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(3))),
                  selectedDate: widget.monthAndYear,
                  onChanged: (dt) {
                    widget.setMonthAndYear(dt);
                    setState(() => _isExpanded = false);
                  },
                  firstDate: DateTime.utc(1990),
                  lastDate: Utils.dateOnlyUTC(DateTime.timestamp()).add(const Duration(days: 10000)))),
        ]));
  }
}
