import 'package:flutter/material.dart';
import 'package:travel_trackr/core/utils/spacing.dart';

import '../../../../core/presentation/widgets/circular_icon.dart';

class MediumDestinationItem extends StatelessWidget {
  final IconData icon;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool editing;

  const MediumDestinationItem({
    Key? key,
    required this.icon,
    this.leading,
    this.trailing,
    this.onTap,
    this.onDelete,
    this.editing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 56.0,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: leading ?? const SizedBox.shrink(),
            ),
            16.0.horizontalSpace,
            ((CircularIconSize.big.size - CircularIconSize.medium.size) / 2)
                .horizontalSpace,
            CircularIcon(
              icon: icon,
              size: CircularIconSize.medium,
            ),
            8.0.horizontalSpace,
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  if (editing) ...[
                    const Icon(
                      Icons.edit_outlined,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    8.0.horizontalSpace,
                  ],
                  if (onDelete != null) ...[
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete_outline,
                        size: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    4.0.horizontalSpace,
                  ],
                  Expanded(child: trailing ?? const SizedBox.shrink()),
                ],
              ),
            ),
            ((CircularIconSize.big.size - CircularIconSize.medium.size) / 2)
                .horizontalSpace,
            8.0.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
