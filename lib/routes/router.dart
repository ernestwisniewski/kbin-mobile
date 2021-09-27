import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/screens/comments_screen.dart';
import 'package:kbin_mobile/screens/entries_screen.dart';
import 'package:kbin_mobile/screens/entry_screen.dart';
import 'package:kbin_mobile/screens/menu_screen.dart';
import 'package:kbin_mobile/screens/posts_screen.dart';
import 'package:kbin_mobile/screens/post_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MenuScreen, initial: true),

    // Entries
    AutoRoute(path: '/t', page: EntriesScreen),
    AutoRoute(path: '/m/:magazine/t/:id', page: EntryScreen),

    // Comments
    AutoRoute(path: '/c', page: CommentsScreen),

    // Microblog
    AutoRoute(path: '/m', page: PostsScreen),
    AutoRoute(path: '/m/:magazine/t/:id', page: PostScreen)
  ],
)
class $AppRouter {}
