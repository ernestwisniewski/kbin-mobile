// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/cupertino.dart' as _i14;
import 'package:flutter/material.dart' as _i13;

import '../screens/comments_screen.dart' as _i8;
import '../screens/entries_screen.dart' as _i6;
import '../screens/entry_screen.dart' as _i7;
import '../screens/magazines_screen.dart' as _i5;
import '../screens/menu_screen.dart' as _i1;
import '../screens/post_screen.dart' as _i10;
import '../screens/posts_screen.dart' as _i9;
import '../screens/search_screen.dart' as _i11;
import '../screens/settings/instance_screen.dart' as _i4;
import '../screens/settings/language_screen.dart' as _i3;
import '../screens/settings_screen.dart' as _i2;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    MenuRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MenuScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SettingsScreen());
    },
    LanguageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.LanguageScreen());
    },
    InstanceRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.InstanceScreen());
    },
    MagazinesRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.MagazinesScreen());
    },
    EntriesRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.EntriesScreen());
    },
    EntryRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<EntryRouteArgs>(
          orElse: () => EntryRouteArgs(
              magazine: pathParams.getString('magazine'),
              id: pathParams.getInt('id')));
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.EntryScreen(
              key: args.key, magazine: args.magazine, id: args.id));
    },
    CommentsRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CommentsScreen());
    },
    PostsRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.PostsScreen());
    },
    PostRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<PostRouteArgs>(
          orElse: () => PostRouteArgs(
              magazine: pathParams.getString('magazine'),
              id: pathParams.getInt('id')));
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.PostScreen(
              key: args.key, magazine: args.magazine, id: args.id));
    },
    SearchRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.SearchScreen());
    }
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(MenuRoute.name, path: '/'),
        _i12.RouteConfig(SettingsRoute.name, path: '/settings'),
        _i12.RouteConfig(LanguageRoute.name, path: '/settings/language'),
        _i12.RouteConfig(InstanceRoute.name, path: '/settings/instance'),
        _i12.RouteConfig(MagazinesRoute.name, path: '/magazines'),
        _i12.RouteConfig(EntriesRoute.name, path: '/t'),
        _i12.RouteConfig(EntryRoute.name, path: '/m/:magazine/t/:id'),
        _i12.RouteConfig(CommentsRoute.name, path: '/c'),
        _i12.RouteConfig(PostsRoute.name, path: '/p'),
        _i12.RouteConfig(PostRoute.name, path: '/p/:magazine/t/:id'),
        _i12.RouteConfig(SearchRoute.name, path: '/search')
      ];
}

/// generated route for [_i1.MenuScreen]
class MenuRoute extends _i12.PageRouteInfo<void> {
  const MenuRoute() : super(name, path: '/');

  static const String name = 'MenuRoute';
}

/// generated route for [_i2.SettingsScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings');

  static const String name = 'SettingsRoute';
}

/// generated route for [_i3.LanguageScreen]
class LanguageRoute extends _i12.PageRouteInfo<void> {
  const LanguageRoute() : super(name, path: '/settings/language');

  static const String name = 'LanguageRoute';
}

/// generated route for [_i4.InstanceScreen]
class InstanceRoute extends _i12.PageRouteInfo<void> {
  const InstanceRoute() : super(name, path: '/settings/instance');

  static const String name = 'InstanceRoute';
}

/// generated route for [_i5.MagazinesScreen]
class MagazinesRoute extends _i12.PageRouteInfo<void> {
  const MagazinesRoute() : super(name, path: '/magazines');

  static const String name = 'MagazinesRoute';
}

/// generated route for [_i6.EntriesScreen]
class EntriesRoute extends _i12.PageRouteInfo<void> {
  const EntriesRoute() : super(name, path: '/t');

  static const String name = 'EntriesRoute';
}

/// generated route for [_i7.EntryScreen]
class EntryRoute extends _i12.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({_i14.Key? key, required String magazine, required int id})
      : super(name,
            path: '/m/:magazine/t/:id',
            args: EntryRouteArgs(key: key, magazine: magazine, id: id),
            rawPathParams: {'magazine': magazine, 'id': id});

  static const String name = 'EntryRoute';
}

class EntryRouteArgs {
  const EntryRouteArgs({this.key, required this.magazine, required this.id});

  final _i14.Key? key;

  final String magazine;

  final int id;
}

/// generated route for [_i8.CommentsScreen]
class CommentsRoute extends _i12.PageRouteInfo<void> {
  const CommentsRoute() : super(name, path: '/c');

  static const String name = 'CommentsRoute';
}

/// generated route for [_i9.PostsScreen]
class PostsRoute extends _i12.PageRouteInfo<void> {
  const PostsRoute() : super(name, path: '/p');

  static const String name = 'PostsRoute';
}

/// generated route for [_i10.PostScreen]
class PostRoute extends _i12.PageRouteInfo<PostRouteArgs> {
  PostRoute({_i14.Key? key, required String magazine, required int id})
      : super(name,
            path: '/p/:magazine/t/:id',
            args: PostRouteArgs(key: key, magazine: magazine, id: id),
            rawPathParams: {'magazine': magazine, 'id': id});

  static const String name = 'PostRoute';
}

class PostRouteArgs {
  const PostRouteArgs({this.key, required this.magazine, required this.id});

  final _i14.Key? key;

  final String magazine;

  final int id;
}

/// generated route for [_i11.SearchScreen]
class SearchRoute extends _i12.PageRouteInfo<void> {
  const SearchRoute() : super(name, path: '/search');

  static const String name = 'SearchRoute';
}
