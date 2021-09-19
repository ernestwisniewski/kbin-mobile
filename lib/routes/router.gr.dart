// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/entries_screen.dart' as _i4;
import '../screens/entry_screen.dart' as _i5;
import '../screens/menu_screen.dart' as _i3;
import '../screens/microblog_screen.dart' as _i6;
import '../screens/post_screen.dart' as _i7;

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
    EntriesRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.EntriesScreen();
        }),
    EntryRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<EntryRouteArgs>(
              orElse: () => EntryRouteArgs(
                  magazine: pathParams.getString('magazine'),
                  id: pathParams.getInt('id')));
          return _i5.EntryScreen(
              key: args.key, magazine: args.magazine, id: args.id);
        }),
    MicroblogRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.MicroblogScreen();
        }),
    PostRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<PostRouteArgs>(
              orElse: () => PostRouteArgs(id: pathParams.getInt('id')));
          return _i7.PostScreen(key: args.key, id: args.id);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MenuRoute.name, path: '/'),
        _i1.RouteConfig(EntriesRoute.name, path: '/t'),
        _i1.RouteConfig(EntryRoute.name, path: '/:magazine/t/:id'),
        _i1.RouteConfig(MicroblogRoute.name, path: '/m'),
        _i1.RouteConfig(PostRoute.name, path: 'm/:id')
      ];
}

class MenuRoute extends _i1.PageRouteInfo<void> {
  const MenuRoute() : super(name, path: '/');

  static const String name = 'MenuRoute';
}

class EntriesRoute extends _i1.PageRouteInfo<void> {
  const EntriesRoute() : super(name, path: '/t');

  static const String name = 'EntriesRoute';
}

class EntryRoute extends _i1.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({_i2.Key? key, required String magazine, required int id})
      : super(name,
            path: '/:magazine/t/:id',
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

class MicroblogRoute extends _i1.PageRouteInfo<void> {
  const MicroblogRoute() : super(name, path: '/m');

  static const String name = 'MicroblogRoute';
}

class PostRoute extends _i1.PageRouteInfo<PostRouteArgs> {
  PostRoute({_i2.Key? key, required int id})
      : super(name,
            path: 'm/:id',
            args: PostRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'PostRoute';
}

class PostRouteArgs {
  const PostRouteArgs({this.key, required this.id});

  final _i2.Key? key;

  final int id;
}
