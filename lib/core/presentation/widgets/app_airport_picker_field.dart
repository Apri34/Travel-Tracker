import 'package:flutter/material.dart';
import 'package:travel_trackr/core/data/models/airport/airport.dart';
import 'package:travel_trackr/core/presentation/bottomsheets/app_bottomsheet.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';

import '../bottomsheets/airport_picker_bottomsheet.dart';
import '../bottomsheets/city_picker_bottomsheet.dart';

class AppAirportPickerField extends StatefulWidget {
  final String? hint;
  final Function(Airport airport)? onAirportSelected;
  final TextEditingController? controller;
  final bool error;
  final bool enabled;

  const AppAirportPickerField({
    Key? key,
    this.hint,
    this.onAirportSelected,
    this.controller,
    this.error = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<AppAirportPickerField> createState() => _AppAirportPickerFieldState();
}

class _AppAirportPickerFieldState extends State<AppAirportPickerField> {
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
      onTap: () {
        showAppBottomsheet(
          context: context,
          bottomsheet: AirportPickerBottomsheet(
            onAirportSelected: (airport) {
              controller.text = airport.name;
              if (widget.onAirportSelected != null) {
                widget.onAirportSelected!(airport);
              }
            },
          ),
        );
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
