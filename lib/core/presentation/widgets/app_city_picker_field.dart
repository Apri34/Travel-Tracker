import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_trackr/core/presentation/bottomsheets/app_bottomsheet.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';

import '../../data/models/city/city.dart';
import '../bottomsheets/city_picker_bottomsheet.dart';

class AppCityPickerField extends StatefulWidget {
  final String? hint;
  final Function(City city)? onCitySelected;
  final String? country;
  final TextEditingController? controller;
  final bool error;
  final bool enabled;

  const AppCityPickerField({
    Key? key,
    this.hint,
    this.onCitySelected,
    this.country,
    this.controller,
    this.error = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<AppCityPickerField> createState() => _AppCityPickerFieldState();
}

class _AppCityPickerFieldState extends State<AppCityPickerField> {
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
          bottomsheet: CityPickerBottomsheet(
            country: widget.country,
            onCitySelected: (city) {
              controller.text = city.name;
              if (widget.onCitySelected != null) {
                widget.onCitySelected!(city);
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
