import 'package:flutter/material.dart';
import 'package:travel_trackr/core/theme/app_colors.dart';

class CustomDatePickerOverlay extends StatelessWidget {
  const CustomDatePickerOverlay({
    Key? key,
    this.capStartEdge = false,
    this.capEndEdge = false,
  }) : super(key: key);

  final bool capStartEdge;
  final bool capEndEdge;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: capStartEdge ? 5.0 : 0.0,
          right: capEndEdge ? 5.0 : 0.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: capStartEdge ? const Radius.circular(10.0) : Radius.zero,
              right: capEndEdge ? const Radius.circular(10.0) : Radius.zero,
            ),
            color: AppColors.primaryColor.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
