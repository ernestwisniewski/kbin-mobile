// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/entries_screen.dart' as _i4;
import '../screens/menu_screen.dart' as _i3;

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
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MenuRoute.name, path: '/'),
        _i1.RouteConfig(EntriesRoute.name, path: '/entries-screen')
      ];
}

class MenuRoute extends _i1.PageRouteInfo<void> {
  const MenuRoute() : super(name, path: '/');

  static const String name = 'MenuRoute';
}

class EntriesRoute extends _i1.PageRouteInfo<void> {
  const EntriesRoute() : super(name, path: '/entries-screen');

  static const String name = 'EntriesRoute';
}
