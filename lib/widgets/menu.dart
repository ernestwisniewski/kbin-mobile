import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';

class MenuItem {
  final String title;
  final String? subtitle;
  final String route;
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
        title: 'Strona główna',
        subtitle: 'Wszystkie treści',
        route: '/front',
        icon: const Icon(Icons.home),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Komentarze',
        subtitle: 'O tym sie dyskutuje',
        route: '/',
        icon: Icon(Icons.comment),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Wpisy',
        subtitle: 'Krótka forma mikroblogowa',
        route: '/microblog',
        icon: Icon(Icons.article),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Karab.in',
        subtitle: 'Informacje o tej instancji',
        route: '/instance',
        icon: Icon(Icons.widgets),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Ustawienia',
        subtitle: 'Ustawienia aplikacji',
        route: '/home',
        icon: Icon(Icons.settings),
        iconContainerColor: Colors.grey),
    MenuItem(
        title: 'Wyszukaj',
        subtitle: 'Znajdź w serwisie',
        route: '/home',
        icon: Icon(Icons.search),
        iconContainerColor: Colors.red),
  ];

  static List<MenuItem> profile = <MenuItem>[
    MenuItem(title: 'Zarejestruj się', route: '/'),
    MenuItem(title: 'Zaloguj się', route: '/')
  ];

  List<MenuItem> getMainEntries() {
    return main;
  }

  List<MenuItem> getProfileEntries() {
    return profile;
  }
}
