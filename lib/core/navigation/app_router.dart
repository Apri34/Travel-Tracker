import 'package:auto_route/auto_route.dart';

import '../../features/destination/presentation/screens/add_destination_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

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
      ];
}
