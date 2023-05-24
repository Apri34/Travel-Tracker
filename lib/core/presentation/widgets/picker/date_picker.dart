import 'package:flutter/material.dart';
import 'package:travel_trackr/core/theme/app_theme.dart';

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async =>
    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) => Theme(
        data: AppTheme.datePickerTheme,
        child: child!,
      ),
    );

Future<DateTime?> showAppDateTimePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async =>
    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) => Theme(
        data: AppTheme.datePickerTheme,
        child: child!,
      ),
    ).then(
      (value) async {
        if (value == null) {
          return null;
        }
        var timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) => Theme(
            data: AppTheme.datePickerTheme,
            child: child!,
          ),
        );
        if (timeOfDay == null) {
          return null;
        }
        return DateTime(
          value.year,
          value.month,
          value.day,
          timeOfDay.hour,
          timeOfDay.minute,
          0,
          0,
          0,
        );
      },
    );
