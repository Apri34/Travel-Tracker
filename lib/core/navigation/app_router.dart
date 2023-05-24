import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../features/destination/presentation/screens/add_destination_screen.dart';
import '../../features/destination/presentation/screens/add_journey_screen.dart';
import '../../features/destination/presentation/screens/add_stay_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../data/entities/destination_entity/destination_entity.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: AddDestinationRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          page: AddStayRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          page: AddJourneyRoute.page,
          fullscreenDialog: true,
        ),
      ];
}
