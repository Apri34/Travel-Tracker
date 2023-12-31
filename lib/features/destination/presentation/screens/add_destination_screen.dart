import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_trackr/core/presentation/widgets/app_city_picker_field.dart';
import 'package:travel_trackr/core/presentation/widgets/app_country_picker_field.dart';
import 'package:travel_trackr/core/presentation/widgets/app_date_picker_field.dart';
import 'package:travel_trackr/core/utils/spacing.dart';
import 'package:travel_trackr/features/destination/presentation/cubit/add_destination/add_destination_cubit.dart';

import '../../../../core/data/entities/destination_entity/destination_entity.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/presentation/app_cubit_screen.dart';
import '../../../../core/presentation/widgets/show_if.dart';

@RoutePage()
class AddDestinationScreen
    extends AppCubitScreen<AddDestinationCubit, AddDestinationState> {
  final QueryDocumentSnapshot<DestinationEntity>? destination;

  const AddDestinationScreen({
    super.key,
    this.destination,
  });

  @override
  void listener(BuildContext context, AddDestinationState state) {
    if (state.destination != null) {
      context.router.pop();
    }
  }

  @override
  void init(AddDestinationCubit bloc) {
    bloc.init(destination);
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(S.of(context).addDestination),
        actions: [
          BlocBuilder<AddDestinationCubit, AddDestinationState>(
            builder: (context, state) => state.saving
                ? const Center(
                    child: SizedBox.square(
                      dimension: 16.0,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : IconButton(
                    onPressed:
                        context.read<AddDestinationCubit>().validateAndSave,
                    icon: const Icon(Icons.check),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: BlocBuilder<AddDestinationCubit, AddDestinationState>(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              50.0.verticalSpace,
              AppCountryPickerField(
                hint: S.of(context).country,
                onCountrySelected:
                    context.read<AddDestinationCubit>().setCountry,
                error: state.countryError,
                enabled: !state.saving,
                controller:
                    context.read<AddDestinationCubit>().countryController,
              ),
              ShowIf(
                show: state.country.isNotEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    25.0.verticalSpace,
                    AppCityPickerField(
                      hint: S.of(context).city,
                      onCitySelected:
                          context.read<AddDestinationCubit>().setCity,
                      country: state.countryCode,
                      controller:
                          context.read<AddDestinationCubit>().cityController,
                      error: state.cityError,
                      enabled: !state.saving,
                    ),
                  ],
                ),
              ),
              25.0.verticalSpace,
              AppDatePickerField(
                hint: S.of(context).startDate,
                onDateSelected:
                    context.read<AddDestinationCubit>().setStartDate,
                lastDate: state.endDate,
                initialDate: state.startDate ?? state.endDate ?? DateTime.now(),
                error: state.startDateError,
                enabled: !state.saving,
                controller:
                    context.read<AddDestinationCubit>().startDateController,
              ),
              ShowIf(
                show: state.startDate != null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    25.0.verticalSpace,
                    AppDatePickerField(
                      hint: S.of(context).endDate,
                      onDateSelected:
                          context.read<AddDestinationCubit>().setEndDate,
                      firstDate: state.startDate,
                      initialDate:
                          state.endDate ?? state.startDate ?? DateTime.now(),
                      enabled: !state.saving,
                      controller:
                          context.read<AddDestinationCubit>().endDateController,
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
