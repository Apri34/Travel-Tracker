import 'package:flutter/material.dart';
import 'package:travel_trackr/core/data/models/country/country.dart';
import 'package:travel_trackr/core/presentation/bottomsheets/country_picker_bottomsheet.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';

import '../bottomsheets/app_bottomsheet.dart';

class AppCountryPickerField extends StatefulWidget {
  final String? hint;
  final Function(Country country)? onCountrySelected;
  final TextEditingController? controller;
  final bool error;

  const AppCountryPickerField({
    Key? key,
    this.hint,
    this.onCountrySelected,
    this.controller,
    this.error = false,
  }) : super(key: key);

  @override
  State<AppCountryPickerField> createState() => _AppCountryPickerFieldState();
}

class _AppCountryPickerFieldState extends State<AppCountryPickerField> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      error: widget.error,
      allowWrite: false,
      hint: widget.hint,
      controller: controller,
      onTap: () async {
        showAppBottomsheet(
          context: context,
          bottomsheet: CountryPickerBottomsheet(
            onCountrySelected: (country) {
              controller.text = country.name;
              if (widget.onCountrySelected != null) {
                widget.onCountrySelected!(country);
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
