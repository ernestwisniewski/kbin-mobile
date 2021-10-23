// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/cupertino.dart' as _i15;
import 'package:flutter/material.dart' as _i14;

import '../screens/comments_screen.dart' as _i9;
import '../screens/entries_screen.dart' as _i7;
import '../screens/entry_screen.dart' as _i8;
import '../screens/magazines_screen.dart' as _i6;
import '../screens/menu_screen.dart' as _i1;
import '../screens/post_screen.dart' as _i11;
import '../screens/posts_screen.dart' as _i10;
import '../screens/scene_screen.dart' as _i5;
import '../screens/search_screen.dart' as _i12;
import '../screens/settings/instance_screen.dart' as _i4;
import '../screens/settings/language_screen.dart' as _i3;
import '../screens/settings_screen.dart' as _i2;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    MenuRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MenuScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SettingsScreen());
    },
    LanguageRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.LanguageScreen());
    },
    InstanceRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.InstanceScreen());
    },
    SceneRoute.name: (routeData) {
      final args = routeData.argsAs<SceneRouteArgs>(
          orElse: () => const SceneRouteArgs());
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.SceneScreen(
              key: args.key, route: args.route, index: args.index));
    },
    MagazinesRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MagazinesScreen());
    },
    EntriesRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.EntriesScreen());
    },
    EntryRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<EntryRouteArgs>(
          orElse: () => EntryRouteArgs(
              magazine: pathParams.getString('magazine'),
              id: pathParams.getInt('id')));
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.EntryScreen(
              key: args.key, magazine: args.magazine, id: args.id));
    },
    CommentsRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CommentsScreen());
    },
    PostsRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.PostsScreen());
    },
    PostRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<PostRouteArgs>(
          orElse: () => PostRouteArgs(
              magazine: pathParams.getString('magazine'),
              id: pathParams.getInt('id')));
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.PostScreen(
              key: args.key, magazine: args.magazine, id: args.id));
    },
    SearchRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.SearchScreen());
    }
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(MenuRoute.name, path: '/'),
        _i13.RouteConfig(SettingsRoute.name, path: '/settings'),
        _i13.RouteConfig(LanguageRoute.name, path: '/settings/language'),
        _i13.RouteConfig(InstanceRoute.name, path: '/settings/instance'),
        _i13.RouteConfig(SceneRoute.name, path: '/scene'),
        _i13.RouteConfig(MagazinesRoute.name, path: '/magazines'),
        _i13.RouteConfig(EntriesRoute.name, path: '/t'),
        _i13.RouteConfig(EntryRoute.name, path: '/m/:magazine/t/:id'),
        _i13.RouteConfig(CommentsRoute.name, path: '/c'),
        _i13.RouteConfig(PostsRoute.name, path: '/p'),
        _i13.RouteConfig(PostRoute.name, path: '/p/:magazine/t/:id'),
        _i13.RouteConfig(SearchRoute.name, path: '/search')
      ];
}

/// generated route for [_i1.MenuScreen]
class MenuRoute extends _i13.PageRouteInfo<void> {
  const MenuRoute() : super(name, path: '/');

  static const String name = 'MenuRoute';
}

/// generated route for [_i2.SettingsScreen]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings');

  static const String name = 'SettingsRoute';
}

/// generated route for [_i3.LanguageScreen]
class LanguageRoute extends _i13.PageRouteInfo<void> {
  const LanguageRoute() : super(name, path: '/settings/language');

  static const String name = 'LanguageRoute';
}

/// generated route for [_i4.InstanceScreen]
class InstanceRoute extends _i13.PageRouteInfo<void> {
  const InstanceRoute() : super(name, path: '/settings/instance');

  static const String name = 'InstanceRoute';
}

/// generated route for [_i5.SceneScreen]
class SceneRoute extends _i13.PageRouteInfo<SceneRouteArgs> {
  SceneRoute({_i15.Key? key, _i13.PageRouteInfo<dynamic>? route, int? index})
      : super(name,
            path: '/scene',
            args: SceneRouteArgs(key: key, route: route, index: index));

  static const String name = 'SceneRoute';
}

class SceneRouteArgs {
  const SceneRouteArgs({this.key, this.route, this.index});

  final _i15.Key? key;

  final _i13.PageRouteInfo<dynamic>? route;

  final int? index;
}

/// generated route for [_i6.MagazinesScreen]
class MagazinesRoute extends _i13.PageRouteInfo<void> {
  const MagazinesRoute() : super(name, path: '/magazines');

  static const String name = 'MagazinesRoute';
}

/// generated route for [_i7.EntriesScreen]
class EntriesRoute extends _i13.PageRouteInfo<void> {
  const EntriesRoute() : super(name, path: '/t');

  static const String name = 'EntriesRoute';
}

/// generated route for [_i8.EntryScreen]
class EntryRoute extends _i13.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({_i15.Key? key, required String magazine, required int id})
      : super(name,
            path: '/m/:magazine/t/:id',
            args: EntryRouteArgs(key: key, magazine: magazine, id: id),
            rawPathParams: {'magazine': magazine, 'id': id});

  static const String name = 'EntryRoute';
}

class EntryRouteArgs {
  const EntryRouteArgs({this.key, required this.magazine, required this.id});

  final _i15.Key? key;

  final String magazine;

  final int id;
}

/// generated route for [_i9.CommentsScreen]
class CommentsRoute extends _i13.PageRouteInfo<void> {
  const CommentsRoute() : super(name, path: '/c');

  static const String name = 'CommentsRoute';
}

/// generated route for [_i10.PostsScreen]
class PostsRoute extends _i13.PageRouteInfo<void> {
  const PostsRoute() : super(name, path: '/p');

  static const String name = 'PostsRoute';
}

/// generated route for [_i11.PostScreen]
class PostRoute extends _i13.PageRouteInfo<PostRouteArgs> {
  PostRoute({_i15.Key? key, required String magazine, required int id})
      : super(name,
            path: '/p/:magazine/t/:id',
            args: PostRouteArgs(key: key, magazine: magazine, id: id),
            rawPathParams: {'magazine': magazine, 'id': id});

  static const String name = 'PostRoute';
}

class PostRouteArgs {
  const PostRouteArgs({this.key, required this.magazine, required this.id});

  final _i15.Key? key;

  final String magazine;

  final int id;
}

/// generated route for [_i12.SearchScreen]
class SearchRoute extends _i13.PageRouteInfo<void> {
  const SearchRoute() : super(name, path: '/search');

  static const String name = 'SearchRoute';
}
