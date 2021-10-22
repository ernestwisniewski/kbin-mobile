import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> main = Menu().getMainEntries();
    List<MenuItem> profile = Menu().getProfileEntries();

    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: TopBar(),
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: main.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      minVerticalPadding: 15,
                      title: Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 35.0,
                                    width: 35.0,
                                    decoration: BoxDecoration(
                                        color: main[index].iconContainerColor,
                                        shape: BoxShape.circle),
                                    child: main[index].icon),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(main[index].title),
                          ),
                        ],
                      ),
                      // subtitle: Text(main[index].subtitle ?? ''),
                      onTap: () {
                        main[index].routeType == 'replace'
                            ? context.router.replace(main[index].route)
                            : context.router.push(main[index].route);
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 0),
              ),
              Material(
                type: MaterialType.transparency,
                child: Container(
                    color: Colors.black12,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Profil'),
                    )),
              ),
              ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: profile.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      title: Text(profile[index].title),
                      onTap: () {
                        context.router.replace(profile[index].route);
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 0),
              )
            ],
          ),
        ));
  }
}

class MenuItem {
  final String title;
  final String? subtitle;
  final PageRouteInfo route;
  final String? routeType;
  final Icon? icon;
  final Color? iconContainerColor;

  MenuItem(
      {required this.title,
      this.subtitle,
      required this.route,
      this.routeType,
      this.icon,
      this.iconContainerColor});
}

class Menu {
  static List<MenuItem> main = <MenuItem>[
    MenuItem(
        title: 'Treści',
        subtitle: 'Strona główna',
        route: const EntriesRoute(),
        icon: const Icon(CupertinoIcons.home, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Komentarze',
        subtitle: 'O tym sie dyskutuje',
        route: const CommentsRoute(),
        icon: const Icon(CupertinoIcons.chat_bubble_2, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Wpisy',
        subtitle: 'Krótka forma mikroblogowa',
        route: const PostsRoute(),
        icon: const Icon(CupertinoIcons.square_list, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Magazyny',
        subtitle: 'Magazyny tematyczne',
        route: const MagazinesRoute(),
        icon: const Icon(CupertinoIcons.tray_2, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Instancja',
        subtitle: 'Informacje o tej instancji',
        route: const MenuRoute(),
        icon: const Icon(CupertinoIcons.circle_grid_hex, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Wyszukaj',
        subtitle: 'Znajdź w serwisie',
        route: const SearchRoute(),
        icon: const Icon(CupertinoIcons.search, color: Colors.white),
        iconContainerColor: Colors.red),
    MenuItem(
        title: 'Ustawienia',
        subtitle: 'Ustawienia aplikacji',
        route: const SettingsRoute(),
        icon: const Icon(CupertinoIcons.settings, color: Colors.white),
        iconContainerColor: Colors.grey),
  ];

  static List<MenuItem> profile = <MenuItem>[
    MenuItem(title: 'Zaloguj się', route: const MenuRoute()),
    MenuItem(title: 'Zarejestruj się', route: const MenuRoute())
  ];

  List<MenuItem> getMainEntries() {
    return main;
  }

  List<MenuItem> getProfileEntries() {
    return profile;
  }
}
