import 'package:flutter/material.dart';
import 'package:travel_trackr/core/presentation/dialogs/app_dialog.dart';

import '../../l10n/generated/l10n.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(S.of(context).okay),
        ),
      ],
    );
  }
}

Future<void> confirm(BuildContext context, String title, String description,
        VoidCallback onConfirm) =>
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: title,
        description: description,
        onConfirm: onConfirm,
      ),
    );
