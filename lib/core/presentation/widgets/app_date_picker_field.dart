import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';
import 'package:travel_trackr/core/presentation/widgets/picker/date_picker.dart';

import '../../utils/date_format_utils.dart';

class AppDatePickerField extends StatefulWidget {
  final String? hint;
  final Function(DateTime date)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? format;
  final TextEditingController? controller;
  final bool error;
  final bool enabled;

  const AppDatePickerField({
    Key? key,
    this.hint,
    this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.format,
    this.controller,
    this.error = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      error: widget.error,
      enabled: widget.enabled,
      allowWrite: false,
      hint: widget.hint,
      controller: controller,
      onTap: () async {
        var date = await showAppDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: widget.firstDate ??
              DateTime.now().subtract(const Duration(days: 500)),
          lastDate:
              widget.lastDate ?? DateTime.now().add(const Duration(days: 1000)),
        );
        if (date != null) {
          if (widget.onDateSelected != null) {
            widget.onDateSelected!(date);
          }
          controller.text =
              (widget.format ?? DateFormatUtils.standard).format(date);
        }
      },
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }
}
