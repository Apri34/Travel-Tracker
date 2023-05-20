import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_trackr/core/data/models/country/country.dart';
import 'package:travel_trackr/core/utils/spacing.dart';
import '../../../../config_reader.dart';

import 'custom_picker_overlay.dart';

const double _kItemExtent = 52.0;

class AppCountryPicker extends StatefulWidget {
  final void Function(Country country) onCountrySelected;
  final VoidCallback onCountryPicked;

  const AppCountryPicker({
    super.key,
    required this.onCountrySelected,
    required this.onCountryPicked,
  });

  @override
  State<StatefulWidget> createState() {
    return _AppCountryPickerState();
  }
}

class _AppCountryPickerState extends State<AppCountryPicker> {
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();
  TapDownDetails? _currentTapDetails;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) => _currentTapDetails = details,
        onTap: () {
          final y = _currentTapDetails!.localPosition.dy;
          if (y > 80 && y < 200 - 80) {
            widget.onCountryPicked();
          }
        },
        child: CupertinoPicker.builder(
          scrollController: scrollController,
          itemExtent: _kItemExtent,
          childCount: Config.countries.length,
          onSelectedItemChanged: (int index) {
            HapticFeedback.mediumImpact();
            widget.onCountrySelected(Config.countries[index]);
          },
          selectionOverlay: const CustomDatePickerOverlay(
            capEndEdge: true,
            capStartEdge: true,
          ),
          itemBuilder: (BuildContext context, int index) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text(Config.countries[index].flag),
                  8.0.horizontalSpace,
                  Expanded(
                    child: AutoSizeText(
                      Config.countries[index].name,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
