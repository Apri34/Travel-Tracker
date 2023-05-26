import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_trackr/core/navigation/app_router.dart';
import 'package:travel_trackr/core/presentation/app_cubit_screen.dart';
import 'package:travel_trackr/core/presentation/widgets/rotating_fab.dart';
import 'package:travel_trackr/core/presentation/widgets/show_if.dart';
import 'package:travel_trackr/core/theme/app_text_theme.dart';
import 'package:travel_trackr/core/utils/spacing.dart';
import 'package:travel_trackr/features/home/presentation/widgets/destination.dart';

import '../../../../core/l10n/generated/l10n.dart';
import '../../../../core/presentation/widgets/app_primary_button.dart';
import '../cubit/home_cubit.dart';
import '../widgets/add_destination_item.dart';

@RoutePage()
class HomeScreen extends AppCubitScreen<HomeCubit, HomeState> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => RotatingFab(
          onPressed: context.read<HomeCubit>().toggleEditing,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => state.destinations.isNotEmpty ||
                  !state.loaded
              ? ListView.builder(
                  itemCount: state.destinations.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.destinations.length) {
                      return ShowIf(
                        show: state.editing,
                        child: AddDestinationItem(
                          onAddDestination: () {
                            context.router.push(AddDestinationRoute());
                          },
                        ),
                      );
                    }
                    return Destination(
                      destination: state.destinations[index].data(),
                      destinationDocId: state.destinations[index].id,
                      editing: state.editing,
                      first: index == 0,
                      last: index == state.destinations.length - 1 &&
                          !state.editing,
                      onDeleteDestination: () => context
                          .read<HomeCubit>()
                          .deleteDestination(state.destinations[index].id),
                      onDeleteJourney: (journeyDocId) => context
                          .read<HomeCubit>()
                          .deleteJourney(
                              state.destinations[index].id, journeyDocId),
                      onDeleteStay: (stayDocId) => context
                          .read<HomeCubit>()
                          .deleteStay(state.destinations[index].id, stayDocId),
                      onEditDestination: () => context.router.push(
                          AddDestinationRoute(
                              destination: state.destinations[index])),
                      onEditJourney: (journey) => context.router.push(
                        AddJourneyRoute(
                          destinationDocId: state.destinations[index].id,
                          journey: journey,
                        ),
                      ),
                      onEditStay: (stay) => context.router.push(
                        AddStayRoute(
                          destinationDocId: state.destinations[index].id,
                          stay: stay,
                          country: state.destinations[index].data().country,
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          S.of(context).emptyDestinationsPlaceholder,
                          style: AppTextTheme.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      12.0.verticalSpace,
                      AppPrimaryButton(
                        label: S.of(context).addDestination,
                        onPressed: () =>
                            context.router.push(AddDestinationRoute()),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
