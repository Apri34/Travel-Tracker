import 'package:flutter/material.dart';
import 'package:travel_trackr/config_reader.dart';
import 'package:travel_trackr/core/presentation/bottomsheets/app_bottomsheet.dart';
import 'package:travel_trackr/core/presentation/widgets/picker/app_country_picker.dart';

import '../../data/models/country/country.dart';

class CountryPickerBottomsheet extends StatefulWidget {
  final void Function(Country country) onCountrySelected;

  const CountryPickerBottomsheet({
    Key? key,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  State<CountryPickerBottomsheet> createState() =>
      _CountryPickerBottomsheetState();
}

class _CountryPickerBottomsheetState extends State<CountryPickerBottomsheet> {
  Country country = Config.countries.first;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onCountrySelected(country);
        return true;
      },
      child: AppBottomsheet(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: AppCountryPicker(
            onCountrySelected: (country) {
              this.country = country;
            },
            onCountryPicked: () {
              widget.onCountrySelected(country);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
