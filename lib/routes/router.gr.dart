// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/cupertino.dart' as _i16;
import 'package:flutter/material.dart' as _i15;

import '../screens/comments_screen.dart' as _i4;
import '../screens/entries_screen.dart' as _i2;
import '../screens/entry_screen.dart' as _i3;
import '../screens/home_screen.dart' as _i1;
import '../screens/magazines_screen.dart' as _i7;
import '../screens/menu_screen.dart' as _i11;
import '../screens/post_screen.dart' as _i6;
import '../screens/posts_screen.dart' as _i5;
import '../screens/scene_screen.dart' as _i12;
import '../screens/search_screen.dart' as _i13;
import '../screens/settings/instance_screen.dart' as _i10;
import '../screens/settings/language_screen.dart' as _i9;
import '../screens/settings_screen.dart' as _i8;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.HomeScreen(),
      );
    },
    EntriesRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EntriesScreen(),
      );
    },
    EntryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EntryRouteArgs>(
          orElse: () => EntryRouteArgs(
                magazine: pathParams.getString('magazine'),
                id: pathParams.getInt('id'),
              ));
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.EntryScreen(
          key: args.key,
          magazine: args.magazine,
          id: args.id,
        ),
      );
    },
    CommentsRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.CommentsScreen(),
      );
    },
    PostsRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.PostsScreen(),
      );
    },
    PostRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PostRouteArgs>(
          orElse: () => PostRouteArgs(
                magazine: pathParams.getString('magazine'),
                id: pathParams.getInt('id'),
              ));
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.PostScreen(
          key: args.key,
          magazine: args.magazine,
          id: args.id,
        ),
      );
    },
    MagazinesRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.MagazinesScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsScreen(),
      );
    },
    LanguageRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.LanguageScreen(),
      );
    },
    InstanceRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.InstanceScreen(),
      );
    },
    MenuRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.MenuScreen(),
      );
    },
    SceneRoute.name: (routeData) {
      final args = routeData.argsAs<SceneRouteArgs>(
          orElse: () => const SceneRouteArgs());
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.SceneScreen(
          key: args.key,
          route: args.route,
          index: args.index,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.SearchScreen(),
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i14.RouteConfig(
          EntriesRoute.name,
          path: '/threads',
        ),
        _i14.RouteConfig(
          EntryRoute.name,
          path: '/m/:magazine/t/:id',
        ),
        _i14.RouteConfig(
          CommentsRoute.name,
          path: '/comments',
        ),
        _i14.RouteConfig(
          PostsRoute.name,
          path: '/posts',
        ),
        _i14.RouteConfig(
          PostRoute.name,
          path: '/p/:magazine/t/:id',
        ),
        _i14.RouteConfig(
          MagazinesRoute.name,
          path: '/magazines',
        ),
        _i14.RouteConfig(
          SettingsRoute.name,
          path: '/settings',
        ),
        _i14.RouteConfig(
          LanguageRoute.name,
          path: '/settings/language',
        ),
        _i14.RouteConfig(
          InstanceRoute.name,
          path: '/settings/instance',
        ),
        _i14.RouteConfig(
          MenuRoute.name,
          path: '/menu',
        ),
        _i14.RouteConfig(
          SceneRoute.name,
          path: '/scene',
        ),
        _i14.RouteConfig(
          SearchRoute.name,
          path: '/search',
        ),
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.EntriesScreen]
class EntriesRoute extends _i14.PageRouteInfo<void> {
  const EntriesRoute()
      : super(
          EntriesRoute.name,
          path: '/threads',
        );

  static const String name = 'EntriesRoute';
}

/// generated route for
/// [_i3.EntryScreen]
class EntryRoute extends _i14.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({
    _i16.Key? key,
    required String magazine,
    required int id,
  }) : super(
          EntryRoute.name,
          path: '/m/:magazine/t/:id',
          args: EntryRouteArgs(
            key: key,
            magazine: magazine,
            id: id,
          ),
          rawPathParams: {
            'magazine': magazine,
            'id': id,
          },
        );

  static const String name = 'EntryRoute';
}

class EntryRouteArgs {
  const EntryRouteArgs({
    this.key,
    required this.magazine,
    required this.id,
  });

  final _i16.Key? key;

  final String magazine;

  final int id;

  @override
  String toString() {
    return 'EntryRouteArgs{key: $key, magazine: $magazine, id: $id}';
  }
}

/// generated route for
/// [_i4.CommentsScreen]
class CommentsRoute extends _i14.PageRouteInfo<void> {
  const CommentsRoute()
      : super(
          CommentsRoute.name,
          path: '/comments',
        );

  static const String name = 'CommentsRoute';
}

/// generated route for
/// [_i5.PostsScreen]
class PostsRoute extends _i14.PageRouteInfo<void> {
  const PostsRoute()
      : super(
          PostsRoute.name,
          path: '/posts',
        );

  static const String name = 'PostsRoute';
}

/// generated route for
/// [_i6.PostScreen]
class PostRoute extends _i14.PageRouteInfo<PostRouteArgs> {
  PostRoute({
    _i16.Key? key,
    required String magazine,
    required int id,
  }) : super(
          PostRoute.name,
          path: '/p/:magazine/t/:id',
          args: PostRouteArgs(
            key: key,
            magazine: magazine,
            id: id,
          ),
          rawPathParams: {
            'magazine': magazine,
            'id': id,
          },
        );

  static const String name = 'PostRoute';
}

class PostRouteArgs {
  const PostRouteArgs({
    this.key,
    required this.magazine,
    required this.id,
  });

  final _i16.Key? key;

  final String magazine;

  final int id;

  @override
  String toString() {
    return 'PostRouteArgs{key: $key, magazine: $magazine, id: $id}';
  }
}

/// generated route for
/// [_i7.MagazinesScreen]
class MagazinesRoute extends _i14.PageRouteInfo<void> {
  const MagazinesRoute()
      : super(
          MagazinesRoute.name,
          path: '/magazines',
        );

  static const String name = 'MagazinesRoute';
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i14.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: '/settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i9.LanguageScreen]
class LanguageRoute extends _i14.PageRouteInfo<void> {
  const LanguageRoute()
      : super(
          LanguageRoute.name,
          path: '/settings/language',
        );

  static const String name = 'LanguageRoute';
}

/// generated route for
/// [_i10.InstanceScreen]
class InstanceRoute extends _i14.PageRouteInfo<void> {
  const InstanceRoute()
      : super(
          InstanceRoute.name,
          path: '/settings/instance',
        );

  static const String name = 'InstanceRoute';
}

/// generated route for
/// [_i11.MenuScreen]
class MenuRoute extends _i14.PageRouteInfo<void> {
  const MenuRoute()
      : super(
          MenuRoute.name,
          path: '/menu',
        );

  static const String name = 'MenuRoute';
}

/// generated route for
/// [_i12.SceneScreen]
class SceneRoute extends _i14.PageRouteInfo<SceneRouteArgs> {
  SceneRoute({
    _i16.Key? key,
    _i14.PageRouteInfo<dynamic>? route,
    int? index,
  }) : super(
          SceneRoute.name,
          path: '/scene',
          args: SceneRouteArgs(
            key: key,
            route: route,
            index: index,
          ),
        );

  static const String name = 'SceneRoute';
}

class SceneRouteArgs {
  const SceneRouteArgs({
    this.key,
    this.route,
    this.index,
  });

  final _i16.Key? key;

  final _i14.PageRouteInfo<dynamic>? route;

  final int? index;

  @override
  String toString() {
    return 'SceneRouteArgs{key: $key, route: $route, index: $index}';
  }
}

/// generated route for
/// [_i13.SearchScreen]
class SearchRoute extends _i14.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search',
        );

  static const String name = 'SearchRoute';
}
