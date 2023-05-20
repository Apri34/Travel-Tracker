import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AppBottomsheet extends StatelessWidget {
  final Widget child;
  final VoidCallback? onClosing;

  const AppBottomsheet({
    Key? key,
    required this.child,
    this.onClosing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: onClosing ?? () {},
      backgroundColor: AppColors.backgroundColor,
      builder: (context) => SafeArea(
        child: child,
      ),
    );
  }
}

Future<T> showAppBottomsheet<T>({
  required BuildContext context,
  required Widget bottomsheet,
}) async {
  return await showModalBottomSheet(
    context: context,
    builder: (context) => bottomsheet,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.0),
      ),
    ),
  );
}
