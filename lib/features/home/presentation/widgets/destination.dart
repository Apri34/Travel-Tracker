import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_trackr/core/data/entities/destination_entity/destination_entity.dart';
import 'package:travel_trackr/core/navigation/app_router.dart';
import 'package:travel_trackr/core/presentation/widgets/show_if.dart';
import 'package:travel_trackr/core/theme/app_text_theme.dart';
import 'package:travel_trackr/core/utils/spacing.dart';
import 'package:travel_trackr/features/home/presentation/widgets/medium_destination_item.dart';

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/presentation/widgets/circular_icon.dart';

class Destination extends StatelessWidget {
  final DestinationEntity destination;
  final String destinationDocId;
  final bool editing;

  const Destination({
    Key? key,
    required this.destinationDocId,
    required this.destination,
    this.editing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        //vertical: 6.0,
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
      children: [
        2.0.verticalSpace,
        ShowIf(
          show: editing,
          child: MediumDestinationItem(
            icon: Icons.airplanemode_on,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 12,
                ),
                4.0.horizontalSpace,
                Text(
                  S.of(context).addFlight,
                  style: AppTextTheme.body,
                ),
              ],
            ),
            onTap: () {},
          ),
        ),
        ShowIf(
          show: editing,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MediumDestinationItem(
                icon: Icons.home,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 12,
                    ),
                    4.0.horizontalSpace,
                    Text(
                      S.of(context).addStay,
                      style: AppTextTheme.body,
                    ),
                  ],
                ),
                onTap: () => context.router.push(AddStayRoute(
                  destinationDocId: destinationDocId,
                  country: destination.country,
                )),
              ),
            ],
          ),
        ),
        2.0.verticalSpace,
      ],
    );
  }
}
