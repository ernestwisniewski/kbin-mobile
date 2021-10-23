import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/screens/posts_screen.dart';
import 'package:kbin_mobile/screens/search_screen.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';

import 'comments_screen.dart';
import 'entries_screen.dart';

class SceneScreen extends StatefulWidget {
  final PageRouteInfo? route;
  final int? index;

  const SceneScreen({Key? key, this.route, this.index}) : super(key: key);

  @override
  _SceneScreenState createState() => _SceneScreenState();
}

class _SceneScreenState extends State<SceneScreen> {
  int? _currentIndex;
  PageRouteInfo? _routeInfo;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _routeInfo = widget.route;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBuilder: (BuildContext context, int i) {
          _currentIndex = _currentIndex ?? resolverRoute(_routeInfo) ?? i;

          if (_currentIndex == 0) {
            _currentIndex = null;
            _routeInfo = null;
            return const EntriesScreen();
          }
          if (_currentIndex == 1) {
            _currentIndex = null;
            _routeInfo = null;
            return const CommentsScreen();
          }
          if (_currentIndex == 2) {
            _currentIndex = null;
            _routeInfo = null;
            return const PostsScreen();
          }
          if (_currentIndex == 3) {
            _currentIndex = null;
            _routeInfo = null;
            return const SearchScreen();
          }
          return Container();
        },
        tabBar: buildBottomNavbar(context, _currentIndex ?? 0));
  }

  int? resolverRoute(PageRouteInfo? route) {
    if (route != null) {
      if (route == const EntriesRoute()) {
        return 0;
      }
      if (route == const CommentsRoute()) {
        return 1;
      }
      if (route == const PostsRoute()) {
        return 2;
      }
      if (route == const SearchRoute()) {
        return 3;
      }
    }

    return null;
  }
}
