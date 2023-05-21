import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_trackr/core/presentation/widgets/app_date_picker_field.dart';
import 'package:travel_trackr/core/presentation/widgets/app_text_field.dart';
import 'package:travel_trackr/core/utils/spacing.dart';
import 'package:travel_trackr/features/destination/presentation/cubit/add_stay/add_stay_cubit.dart';

import '../../../../core/data/entities/destination_entity/destination_entity.dart';
import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/presentation/app_cubit_screen.dart';
import '../../../../core/presentation/widgets/show_if.dart';

@RoutePage()
class AddStayScreen extends AppCubitScreen<AddStayCubit, AddStayState> {
  final String destinationDocId;
  final String country;

  const AddStayScreen({
    super.key,
    required this.destinationDocId,
    required this.country,
  });

  @override
  void init(AddStayCubit bloc) {
    bloc.init(destinationDocId, country);
  }

  @override
  void listener(BuildContext context, AddStayState state) {
    if (state.stay != null) {
      context.router.pop();
    }
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(S.of(context).addStay),
        actions: [
          BlocBuilder<AddStayCubit, AddStayState>(
            builder: (context, state) => state.saving
                ? const Center(
                    child: SizedBox.square(
                      dimension: 16.0,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : IconButton(
                    onPressed: context.read<AddStayCubit>().validateAndSave,
                    icon: const Icon(Icons.check),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: BlocBuilder<AddStayCubit, AddStayState>(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              50.0.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hint: S.of(context).zip,
                      error: state.zipError,
                      enabled: !state.saving,
                      onChanged: context.read<AddStayCubit>().setZip,
                    ),
                  ),
                  25.0.horizontalSpace,
                  Expanded(
                    child: AppTextField(
                      hint: S.of(context).city,
                      error: state.cityError,
                      enabled: !state.saving,
                      onChanged: context.read<AddStayCubit>().setCity,
                    ),
                  ),
                ],
              ),
              25.0.verticalSpace,
              AppTextField(
                hint: S.of(context).address,
                error: state.addressError,
                enabled: !state.saving,
                onChanged: context.read<AddStayCubit>().setAddress,
              ),
              25.0.verticalSpace,
              AppDatePickerField(
                hint: S.of(context).startDate,
                onDateSelected: context.read<AddStayCubit>().setStartDate,
                lastDate: state.endDate,
                initialDate: state.startDate ?? state.endDate ?? DateTime.now(),
                enabled: !state.saving,
              ),
              ShowIf(
                show: state.startDate != null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    25.0.verticalSpace,
                    AppDatePickerField(
                      hint: S.of(context).endDate,
                      onDateSelected: context.read<AddStayCubit>().setEndDate,
                      firstDate: state.startDate,
                      initialDate:
                          state.endDate ?? state.startDate ?? DateTime.now(),
                      enabled: !state.saving,
                    ),
                  ],
                ),
              ),
              25.0.verticalSpace,
              AppTextField(
                hint: S.of(context).comment,
                enabled: !state.saving,
                onChanged: context.read<AddStayCubit>().setComment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
