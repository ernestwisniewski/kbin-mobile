import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MenuItem> mainMenuEntries = Menu().getMainMenuEntries();
    List<MenuItem> profileMenuEntries = Menu().getProfileMenuEntries();

    return Scaffold(
      appBar: AppBar(
        title: Text('karab.in'),
      ),
      body: ListView(
        children: <Widget>[
          ListView.separated(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: mainMenuEntries.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        color: mainMenuEntries[index].iconContainerColor,
                        shape: BoxShape.circle),
                    child: (mainMenuEntries[index].title == 'Karab.in')
                        ? Image.asset('assets/karabin_icon.png')
                        : mainMenuEntries[index].icon
                    // @todo
                    ),
                title: Text(mainMenuEntries[index].title),
                subtitle: Text(mainMenuEntries[index].subtitle ?? ''),
                enabled: (mainMenuEntries[index].title == 'Subskrybowane'
                    ? false
                    : true),
                // @todo
                onTap: () {
                  Navigator.popAndPushNamed(
                      context, mainMenuEntries[index].route);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
          ),
          Container(
              color: Colors.black12,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Profil'),
              )),
          ListView.separated(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: profileMenuEntries.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(profileMenuEntries[index].title),
                onTap: () {
                  Navigator.pushNamed(context, profileMenuEntries[index].route);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String? subtitle;
  final String route;
  final Icon? icon;
  final Color? iconContainerColor;

  MenuItem({required this.title, this.subtitle, required this.route, this.icon, this.iconContainerColor});
}

class Menu {
  MenuItem test = MenuItem(
      title: 'Strona główna',
      subtitle: 'Wszystkie treści',
      route: '/',
      icon: const Icon(Icons.home),
      iconContainerColor: Colors.blue);

  static List<MenuItem> mainMenuEntries = <MenuItem>[
    MenuItem(
        title: 'Strona główna',
        subtitle: 'Wszystkie treści',
        route: '/',
        icon: const Icon(Icons.home),
        iconContainerColor: Colors.blue),
    MenuItem(
        title: 'Subskrybowane',
        subtitle: 'Dopasowane do ciebie treści',
        route: '/',
        icon: Icon(Icons.star),
        iconContainerColor: Colors.blue)
  ];

  static List<MenuItem> profileMenuEntries = <MenuItem>[
    MenuItem(title: 'Zarejestruj się', route: '/'),
    MenuItem(title: 'Zaloguj się', route: '/')
  ];

  List<MenuItem> getMainMenuEntries() {
    return mainMenuEntries;
  }

  List<MenuItem> getProfileMenuEntries() {
    return profileMenuEntries;
  }
}
