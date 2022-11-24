import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/screens/comments_screen.dart';
import 'package:kbin_mobile/screens/entries_screen.dart';
import 'package:kbin_mobile/screens/entry_screen.dart';
import 'package:kbin_mobile/screens/home_screen.dart';
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
    // Entries
    AutoRoute(path: '/', page: HomeScreen, initial: true),

    AutoRoute(path: '/threads', page: EntriesScreen),
    AutoRoute(path: '/m/:magazine/t/:id', page: EntryScreen),

    // Comments
    AutoRoute(path: '/comments', page: CommentsScreen),

    // Microblog
    AutoRoute(path: '/posts', page: PostsScreen),
    AutoRoute(path: '/p/:magazine/t/:id', page: PostScreen),

    // Magazines
    AutoRoute(path: '/magazines', page: MagazinesScreen),

    // Settings
    AutoRoute(path: '/settings', page: SettingsScreen),
    AutoRoute(path: '/settings/language', page: LanguageScreen),
    AutoRoute(path: '/settings/instance', page: InstanceScreen),

    // Menu
    AutoRoute(path: '/menu', page: MenuScreen),

    // Scene
    AutoRoute(path: '/scene', page: SceneScreen),

    AutoRoute(path: '/search', page: SearchScreen),
  ],
)
class $AppRouter {}
