import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_trackr/core/presentation/app_cubit_screen.dart';
import 'package:travel_trackr/core/presentation/widgets/rotating_fab.dart';
import 'package:travel_trackr/features/home/presentation/widgets/destination.dart';

import '../cubit/home_cubit.dart';

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
          builder: (context, state) => ListView.builder(
            itemCount: state.destinations.length,
            itemBuilder: (context, index) {
              return Destination(
                destination: state.destinations[index].data(),
                destinationDocId: state.destinations[index].id,
                editing: state.editing,
                first: index == 0,
                last: index == state.destinations.length - 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
