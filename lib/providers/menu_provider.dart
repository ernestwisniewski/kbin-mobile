import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

class MenuItem {
  final String title;
  final String? subtitle;
  final PageRouteInfo route;
  final Icon? icon;
  final Color? iconContainerColor;

  MenuItem(
      {required this.title,
        this.subtitle,
        required this.route,
        this.icon,
        this.iconContainerColor});
}

class Menu {
  static List<MenuItem> main = <MenuItem>[
    MenuItem(
        title: 'Treści',
        subtitle: 'Strona główna',
        route: const EntriesRoute(),
        icon: const Icon(Icons.format_list_bulleted, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Komentarze',
        subtitle: 'O tym sie dyskutuje',
        route: const CommentsRoute(),
        icon: const Icon(Icons.comment, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Wpisy',
        subtitle: 'Krótka forma mikroblogowa',
        route: const PostsRoute(),
        icon: const Icon(Icons.article, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Magazyny',
        subtitle: 'Magazyny tematyczne',
        route: const MagazinesRoute(),
        icon: const Icon(Icons.bookmarks , color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Karab.in',
        subtitle: 'Informacje o tej instancji',
        route: const MenuRoute(),
        icon: const Icon(Icons.widgets, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Ustawienia',
        subtitle: 'Ustawienia aplikacji',
        route: const MenuRoute(),
        icon: const Icon(Icons.settings, color: Colors.white),
        iconContainerColor: Colors.grey),
    MenuItem(
        title: 'Wyszukaj',
        subtitle: 'Znajdź w serwisie',
        route: const SearchRoute(),
        icon: const Icon(Icons.search, color: Colors.white),
        iconContainerColor: Colors.red),
  ];

  static List<MenuItem> profile = <MenuItem>[
    MenuItem(title: 'Zaloguj się', route:  const MenuRoute()),
    MenuItem(title: 'Zarejestruj się', route:  const MenuRoute())
  ];

  List<MenuItem> getMainEntries() {
    return main;
  }

  List<MenuItem> getProfileEntries() {
    return profile;
  }


}
