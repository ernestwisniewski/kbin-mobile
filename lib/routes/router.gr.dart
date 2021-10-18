// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/comments_screen.dart' as _i9;
import '../screens/entries_screen.dart' as _i7;
import '../screens/entry_screen.dart' as _i8;
import '../screens/magazines_screen.dart' as _i6;
import '../screens/menu_screen.dart' as _i3;
import '../screens/post_screen.dart' as _i11;
import '../screens/posts_screen.dart' as _i10;
import '../screens/search_screen.dart' as _i12;
import '../screens/settings/language_screen.dart' as _i5;
import '../screens/settings_screen.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MenuRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.MenuScreen();
        }),
    SettingsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.SettingsScreen();
        }),
    LanguageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.LanguageScreen();
        }),
    MagazinesRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.MagazinesScreen();
        }),
    EntriesRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.EntriesScreen();
        }),
    EntryRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<EntryRouteArgs>(
              orElse: () => EntryRouteArgs(
                  magazine: pathParams.getString('magazine'),
                  id: pathParams.getInt('id')));
          return _i8.EntryScreen(
              key: args.key, magazine: args.magazine, id: args.id);
        }),
    CommentsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i9.CommentsScreen();
        }),
    PostsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i10.PostsScreen();
        }),
    PostRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<PostRouteArgs>(
              orElse: () => PostRouteArgs(
                  magazine: pathParams.getString('magazine'),
                  id: pathParams.getInt('id')));
          return _i11.PostScreen(
              key: args.key, magazine: args.magazine, id: args.id);
        }),
    SearchRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i12.SearchScreen();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MenuRoute.name, path: '/'),
        _i1.RouteConfig(SettingsRoute.name, path: '/settings'),
        _i1.RouteConfig(LanguageRoute.name, path: '/settings/language'),
        _i1.RouteConfig(MagazinesRoute.name, path: '/magazines'),
        _i1.RouteConfig(EntriesRoute.name, path: '/t'),
        _i1.RouteConfig(EntryRoute.name, path: '/m/:magazine/t/:id'),
        _i1.RouteConfig(CommentsRoute.name, path: '/c'),
        _i1.RouteConfig(PostsRoute.name, path: '/p'),
        _i1.RouteConfig(PostRoute.name, path: '/p/:magazine/t/:id'),
        _i1.RouteConfig(SearchRoute.name, path: '/search')
      ];
}

class MenuRoute extends _i1.PageRouteInfo<void> {
  const MenuRoute() : super(name, path: '/');

  static const String name = 'MenuRoute';
}

class SettingsRoute extends _i1.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings');

  static const String name = 'SettingsRoute';
}

class LanguageRoute extends _i1.PageRouteInfo<void> {
  const LanguageRoute() : super(name, path: '/settings/language');

  static const String name = 'LanguageRoute';
}

class MagazinesRoute extends _i1.PageRouteInfo<void> {
  const MagazinesRoute() : super(name, path: '/magazines');

  static const String name = 'MagazinesRoute';
}

class EntriesRoute extends _i1.PageRouteInfo<void> {
  const EntriesRoute() : super(name, path: '/t');

  static const String name = 'EntriesRoute';
}

class EntryRoute extends _i1.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({_i2.Key? key, required String magazine, required int id})
      : super(name,
            path: '/m/:magazine/t/:id',
            args: EntryRouteArgs(key: key, magazine: magazine, id: id),
            rawPathParams: {'magazine': magazine, 'id': id});

  static const String name = 'EntryRoute';
}

class EntryRouteArgs {
  const EntryRouteArgs({this.key, required this.magazine, required this.id});

  final _i2.Key? key;

  final String magazine;

  final int id;
}

class CommentsRoute extends _i1.PageRouteInfo<void> {
  const CommentsRoute() : super(name, path: '/c');

  static const String name = 'CommentsRoute';
}

class PostsRoute extends _i1.PageRouteInfo<void> {
  const PostsRoute() : super(name, path: '/p');

  static const String name = 'PostsRoute';
}

class PostRoute extends _i1.PageRouteInfo<PostRouteArgs> {
  PostRoute({_i2.Key? key, required String magazine, required int id})
      : super(name,
            path: '/p/:magazine/t/:id',
            args: PostRouteArgs(key: key, magazine: magazine, id: id),
            rawPathParams: {'magazine': magazine, 'id': id});

  static const String name = 'PostRoute';
}

class PostRouteArgs {
  const PostRouteArgs({this.key, required this.magazine, required this.id});

  final _i2.Key? key;

  final String magazine;

  final int id;
}

class SearchRoute extends _i1.PageRouteInfo<void> {
  const SearchRoute() : super(name, path: '/search');

  static const String name = 'SearchRoute';
}
