import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/screens/comments_screen.dart';
import 'package:kbin_mobile/screens/entries_screen.dart';
import 'package:kbin_mobile/screens/entry_screen.dart';
import 'package:kbin_mobile/screens/magazines_screen.dart';
import 'package:kbin_mobile/screens/menu_screen.dart';
import 'package:kbin_mobile/screens/post_screen.dart';
import 'package:kbin_mobile/screens/posts_screen.dart';
import 'package:kbin_mobile/screens/scene_screen.dart';
import 'package:kbin_mobile/screens/search_screen.dart';
import 'package:kbin_mobile/screens/settings/instance_screen.dart';
import 'package:kbin_mobile/screens/settings/language_screen.dart';
import 'package:kbin_mobile/screens/settings_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MenuScreen, initial: true),

    // Settings
    AutoRoute(path: '/settings', page: SettingsScreen),
    AutoRoute(path: '/settings/language', page: LanguageScreen),
    AutoRoute(path: '/settings/instance', page: InstanceScreen),

    // Scene
    AutoRoute(path: '/scene', page: SceneScreen),

    // Magazines
    AutoRoute(path: '/magazines', page: MagazinesScreen),

    // Entries
    AutoRoute(path: '/t', page: EntriesScreen),
    AutoRoute(path: '/m/:magazine/t/:id', page: EntryScreen),

    // Comments
    AutoRoute(path: '/c', page: CommentsScreen),

    // Microblog
    AutoRoute(path: '/p', page: PostsScreen),
    AutoRoute(path: '/p/:magazine/t/:id', page: PostScreen),

    AutoRoute(path: '/search', page: SearchScreen),
  ],
)
class $AppRouter {}
