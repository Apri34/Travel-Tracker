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
