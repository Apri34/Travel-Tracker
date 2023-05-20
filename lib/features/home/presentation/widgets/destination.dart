import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_trackr/core/data/entities/destination_entity/destination_entity.dart';
import 'package:travel_trackr/core/theme/app_text_theme.dart';
import 'package:travel_trackr/core/utils/spacing.dart';

import '../../../../core/presentation/widgets/circular_icon.dart';

class Destination extends StatelessWidget {
  final DestinationEntity destination;

  const Destination({
    Key? key,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 6.0,
      ),
      collapsedIconColor: Colors.white,
      iconColor: Colors.white,
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: AutoSizeText(
              destination.dateString,
              style: AppTextTheme.body,
            ),
          ),
          16.0.horizontalSpace,
          const CircularIcon(
            icon: Icons.location_on,
          ),
          16.0.horizontalSpace,
          Expanded(
            flex: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.city,
                  style: AppTextTheme.headline2,
                ),
                Text(
                  destination.country,
                  style: AppTextTheme.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
