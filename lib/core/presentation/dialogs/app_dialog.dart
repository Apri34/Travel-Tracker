import 'package:flutter/material.dart';
import 'package:travel_trackr/core/theme/app_colors.dart';
import 'package:travel_trackr/core/theme/app_text_theme.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<Widget>? actions;

  const AppDialog({
    Key? key,
    required this.title,
    this.content,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: actions,
      backgroundColor: AppColors.backgroundColor,
      titleTextStyle: AppTextTheme.headline,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }
}
