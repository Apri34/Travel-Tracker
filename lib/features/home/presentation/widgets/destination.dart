import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:travel_trackr/core/data/api/firebase/firestore_api.dart';
import 'package:travel_trackr/core/data/entities/destination_entity/destination_entity.dart';
import 'package:travel_trackr/core/data/entities/journey_entity/journey_entity.dart';
import 'package:travel_trackr/core/data/entities/stay_entity/stay_entity.dart';
import 'package:travel_trackr/core/navigation/app_router.dart';
import 'package:travel_trackr/core/presentation/dialogs/confirm_dialog.dart';
import 'package:travel_trackr/core/presentation/widgets/show_if.dart';
import 'package:travel_trackr/core/theme/app_text_theme.dart';
import 'package:travel_trackr/core/utils/spacing.dart';
import 'package:travel_trackr/features/home/presentation/widgets/medium_destination_item.dart';

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/presentation/widgets/circular_icon.dart';
import '../../../../core/theme/app_colors.dart';

class Destination extends StatelessWidget {
  final DestinationEntity destination;
  final String destinationDocId;
  final bool editing;
  final bool first;
  final bool last;
  final VoidCallback? onDeleteDestination;
  final void Function(String journeyId)? onDeleteJourney;
  final void Function(String stayId)? onDeleteStay;

  const Destination({
    Key? key,
    required this.destinationDocId,
    required this.destination,
    this.editing = false,
    this.first = false,
    this.last = false,
    this.onDeleteJourney,
    this.onDeleteStay,
    this.onDeleteDestination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: first ? 16 : 0,
          bottom: last ? 16 : 0,
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
        ExpansionTile(
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
                  style: AppTextTheme.bodySmall,
                ),
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
                    if (editing && onDeleteDestination != null) ...[
                      GestureDetector(
                        onTap: () => confirm(
                          context,
                          S.of(context).deleteDestinationTitle,
                          S.of(context).deleteDestinationDescription,
                          onDeleteDestination!,
                        ),
                        child: const Icon(Icons.delete_outline),
                      ),
                      8.0.horizontalSpace,
                    ],
                    Expanded(
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
                            style: AppTextTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            2.0.verticalSpace,
            FirestoreQueryBuilder<JourneyEntity>(
              query: FirestoreQueries.getJourneysQuery(destinationDocId),
              builder: (context, snapshot, _) => Column(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.docs
                    .map((e) => MediumDestinationItem(
                          icon: Icons.airplanemode_on,
                          onDelete: editing && onDeleteJourney != null
                              ? () {
                                  confirm(
                                    context,
                                    S.of(context).deleteJourneyTitle,
                                    S.of(context).deleteJourneyDescription,
                                    () {
                                      onDeleteJourney!(e.id);
                                    },
                                  );
                                }
                              : null,
                          onTap: editing
                              ? () {
                                  print("EDIT");
                                }
                              : null,
                          trailing: Text(
                            "${e.data().from} - ${e.data().to}",
                            style: AppTextTheme.bodySmall,
                          ),
                        ))
                    .toList(),
              ),
            ),
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
                      S.of(context).addJourney,
                      style: AppTextTheme.bodySmall,
                    ),
                  ],
                ),
                onTap: () => context.router.push(AddJourneyRoute(
                  destinationDocId: destinationDocId,
                )),
              ),
            ),
            FirestoreQueryBuilder<StayEntity>(
              query: FirestoreQueries.getStaysQuery(destinationDocId),
              builder: (context, snapshot, _) => Column(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.docs
                    .map((e) => MediumDestinationItem(
                          icon: Icons.home,
                          trailing: Text(
                            e.data().address,
                            style: AppTextTheme.bodySmall,
                          ),
                          onDelete: editing && onDeleteStay != null
                              ? () {
                                  confirm(
                                    context,
                                    S.of(context).deleteStayTitle,
                                    S.of(context).deleteStayDescription,
                                    () {
                                      onDeleteStay!(e.id);
                                    },
                                  );
                                }
                              : null,
                          onTap: editing ? () {} : null,
                        ))
                    .toList(),
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
                          style: AppTextTheme.bodySmall,
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
        ),
      ],
    );
  }
}
