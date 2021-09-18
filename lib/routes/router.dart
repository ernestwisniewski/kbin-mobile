import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/screens/entries_screen.dart';
import 'package:kbin_mobile/screens/menu_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MenuScreen, initial: true),
    AutoRoute(page: EntriesScreen),
  ],
)
class $AppRouter {}