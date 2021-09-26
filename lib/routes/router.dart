import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/screens/comments_screen.dart';
import 'package:kbin_mobile/screens/entries_screen.dart';
import 'package:kbin_mobile/screens/entry_screen.dart';
import 'package:kbin_mobile/screens/menu_screen.dart';
import 'package:kbin_mobile/screens/microblog_screen.dart';
import 'package:kbin_mobile/screens/post_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MenuScreen, initial: true),

    // Entries
    AutoRoute(path: '/t', page: EntriesScreen),
    AutoRoute(path: '/:magazine/t/:id', page: EntryScreen),

    // Comments
    AutoRoute(path: '/c', page: CommentsScreen),

    // Microblog
    AutoRoute(path: '/m', page: MicroblogScreen),
    AutoRoute(path: 'm/:id', page: PostScreen)
  ],
)
class $AppRouter {}
