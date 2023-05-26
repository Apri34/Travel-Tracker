import 'package:flutter/material.dart';
import 'package:travel_trackr/core/utils/spacing.dart';

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/presentation/widgets/circular_icon.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_theme.dart';

class AddDestinationItem extends StatelessWidget {
  final VoidCallback? onAddDestination;

  const AddDestinationItem({
    Key? key,
    this.onAddDestination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          bottom: 16,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 56.0,
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: SizedBox.shrink(),
                ),
                16.0.horizontalSpace,
                SizedBox(
                  width: CircularIconSize.big.size,
                  child: Center(
                    child: Container(
                      width: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                16.0.horizontalSpace,
                const Expanded(
                  flex: 8,
                  child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: onAddDestination,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 56.0,
              top: 6.0,
              bottom: 6.0,
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: SizedBox.shrink(),
                ),
                16.0.horizontalSpace,
                const CircularIcon(
                  icon: Icons.location_on,
                ),
                16.0.horizontalSpace,
                Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      6.0.horizontalSpace,
                      Expanded(
                        child: Text(
                          S.of(context).addDestination,
                          style: AppTextTheme.headline2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
