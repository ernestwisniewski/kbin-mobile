import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:theme_provider/theme_provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MenuItem> main = Menu().getMainEntries();
    List<MenuItem> profile = Menu().getProfileEntries();

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(),
      ),
      body: ListView(
        children: <Widget>[
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: main.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                minVerticalPadding: 15,
                title: Row(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 40.0,
                              width: 40.0,
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
                  context.router.replace(main[index].route);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
          ),
          ListTile(
            minVerticalPadding: 15,
            title: Row(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle),
                          child: const Icon(Icons.lightbulb, color: Colors.white)),
                    ]),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Zmień motyw'),
                ),
              ],
            ),
            // subtitle: Text(main[index].subtitle ?? ''),
            onTap: () {
              ThemeProvider.controllerOf(context).nextTheme();
            },
          ),
          Container(
              color: Colors.black12,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Profil'),
              )),
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: profile.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(profile[index].title),
                onTap: () {
                  context.router.replace(profile[index].route);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
          )
        ],
      ),
    );
  }
}

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
        icon: const Icon(Icons.bookmarks, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Karab.in',
        subtitle: 'Informacje o tej instancji',
        route: const MenuRoute(),
        icon: const Icon(Icons.widgets, color: Colors.white),
        iconContainerColor: KbinColors().fromHex('556880')),
    MenuItem(
        title: 'Wyszukaj',
        subtitle: 'Znajdź w serwisie',
        route: const SearchRoute(),
        icon: const Icon(Icons.search, color: Colors.white),
        iconContainerColor: Colors.red),
    MenuItem(
        title: 'Ustawienia',
        subtitle: 'Ustawienia aplikacji',
        route: const MenuRoute(),
        icon: const Icon(Icons.settings, color: Colors.white),
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
