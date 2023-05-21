import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:travel_trackr/core/data/api/firebase/firestore_api.dart';
import 'package:travel_trackr/core/navigation/app_router.dart';
import 'package:travel_trackr/core/presentation/app_cubit_screen.dart';
import 'package:travel_trackr/core/presentation/widgets/rotating_fab.dart';
import 'package:travel_trackr/features/home/presentation/widgets/destination.dart';

import '../../../../core/data/entities/destination_entity/destination_entity.dart';
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
        child: FirestoreListView<DestinationEntity>(
          query: FirestoreQueries.destinationsQuery,
          pageSize: 20,
          itemBuilder: (context, doc) {
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) => Destination(
                destination: doc.data(),
                editing: state.editing,
              ),
            );
          },
          loadingBuilder: (context) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
