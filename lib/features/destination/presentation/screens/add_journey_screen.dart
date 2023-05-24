import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_trackr/core/data/entities/journey_entity/journey_entity.dart';
import 'package:travel_trackr/core/presentation/widgets/app_airport_picker_field.dart';
import 'package:travel_trackr/core/presentation/widgets/app_city_picker_field.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';
import 'package:travel_trackr/core/presentation/widgets/custom_dropdown.dart';
import 'package:travel_trackr/core/presentation/widgets/show_if.dart';
import 'package:travel_trackr/core/utils/spacing.dart';
import 'package:travel_trackr/features/destination/presentation/cubit/add_journey/add_journey_cubit.dart';

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/presentation/app_cubit_screen.dart';
import '../../../../core/presentation/widgets/app_date_time_picker_field.dart';

@RoutePage()
class AddJourneyScreen
    extends AppCubitScreen<AddJourneyCubit, AddJourneyState> {
  final String destinationDocId;
  final QueryDocumentSnapshot<JourneyEntity>? journey;

  const AddJourneyScreen({
    super.key,
    required this.destinationDocId,
    this.journey,
  });

  @override
  void init(AddJourneyCubit bloc) {
    bloc.init(destinationDocId, journey);
  }

  @override
  void listener(BuildContext context, AddJourneyState state) {
    if (state.journey != null) {
      context.router.pop();
    }
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(S.of(context).addJourney),
        actions: [
          BlocBuilder<AddJourneyCubit, AddJourneyState>(
            builder: (context, state) => state.saving
                ? const Center(
                    child: SizedBox.square(
                      dimension: 16.0,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : IconButton(
                    onPressed: context.read<AddJourneyCubit>().validateAndSave,
                    icon: const Icon(Icons.check),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: BlocBuilder<AddJourneyCubit, AddJourneyState>(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              50.0.verticalSpace,
              AppDropdown<JourneyType>(
                items: JourneyType.values,
                textBuilder: (e) => e.asString(context),
                hint: S.of(context).journeyType,
                onChange: (type, index) =>
                    context.read<AddJourneyCubit>().setJourneyType(type),
                enabled: !state.saving,
                error: state.journeyTypeError,
                startIndex: state.journeyType != null
                    ? JourneyType.values.indexOf(state.journeyType!)
                    : null,
              ),
              ShowIf(
                show: state.journeyType != null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.journeyType?.destinationType ==
                        DestinationType.airport) ...[
                      25.0.verticalSpace,
                      AppAirportPickerField(
                        hint: S.of(context).from,
                        onAirportSelected: (airport) => context
                            .read<AddJourneyCubit>()
                            .setFrom(airport.iata.isNotEmpty
                                ? airport.iata
                                : airport.city),
                        enabled: !state.saving,
                        error: state.fromError,
                        controller:
                            context.read<AddJourneyCubit>().fromController,
                      ),
                      25.0.verticalSpace,
                      AppAirportPickerField(
                        hint: S.of(context).to,
                        onAirportSelected: (airport) => context
                            .read<AddJourneyCubit>()
                            .setTo(airport.iata.isNotEmpty
                                ? airport.iata
                                : airport.city),
                        enabled: !state.saving,
                        error: state.toError,
                        controller:
                            context.read<AddJourneyCubit>().toController,
                      ),
                    ] else ...[
                      25.0.verticalSpace,
                      AppCityPickerField(
                        hint: S.of(context).from,
                        onCitySelected: (city) =>
                            context.read<AddJourneyCubit>().setFrom(city.name),
                        enabled: !state.saving,
                        error: state.fromError,
                        controller:
                            context.read<AddJourneyCubit>().fromController,
                      ),
                      25.0.verticalSpace,
                      AppCityPickerField(
                        hint: S.of(context).to,
                        onCitySelected: (city) =>
                            context.read<AddJourneyCubit>().setTo(city.name),
                        enabled: !state.saving,
                        error: state.toError,
                        controller:
                            context.read<AddJourneyCubit>().toController,
                      ),
                    ],
                    25.0.verticalSpace,
                    AppDateTimePickerField(
                      hint: S.of(context).startDate,
                      lastDate: state.endDate,
                      initialDate:
                          state.startDate ?? state.endDate ?? DateTime.now(),
                      onDateSelected:
                          context.read<AddJourneyCubit>().setStartDate,
                      enabled: !state.saving,
                      controller:
                          context.read<AddJourneyCubit>().startDateController,
                    ),
                    25.0.verticalSpace,
                    AppDateTimePickerField(
                      hint: S.of(context).endDate,
                      firstDate: state.startDate,
                      initialDate:
                          state.endDate ?? state.startDate ?? DateTime.now(),
                      onDateSelected:
                          context.read<AddJourneyCubit>().setEndDate,
                      enabled: !state.saving,
                      controller:
                          context.read<AddJourneyCubit>().endDateController,
                    ),
                    25.0.verticalSpace,
                    AppTextField(
                      hint: S.of(context).comment,
                      onChanged: context.read<AddJourneyCubit>().setComment,
                      enabled: !state.saving,
                      controller:
                          context.read<AddJourneyCubit>().commentController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
