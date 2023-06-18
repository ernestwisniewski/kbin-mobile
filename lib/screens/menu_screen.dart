import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
    List<MenuItem> main = Menu().getMainEntries(context);
    List<MenuItem> profile = Menu().getProfileEntries(context);

    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: FittedBox(child: NavBarMiddle()),
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
                                  child: main[index].icon,
                                ),
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
                        // main[index].routeType == 'replace'
                        //     ? context.router.replace(main[index].route)
                        //     : context.router.navigate(main[index].route);
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(AppLocalizations.of(context)!.settings_account),
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

  MenuItem({
    required this.title,
    this.subtitle,
    required this.route,
    this.routeType,
    this.icon,
    this.iconContainerColor,
  });
}

class Menu {
  List<MenuItem> getMainEntries(BuildContext context) {
    return <MenuItem>[
      MenuItem(
          title: AppLocalizations.of(context)!.home,
          route: SceneRoute(index: 0),
          routeType: 'tab',
          icon: const Icon(CupertinoIcons.square_list, color: Colors.white),
          iconContainerColor: KbinColors().fromHex('556880')),
      MenuItem(
          title: AppLocalizations.of(context)!.comments,
          route: SceneRoute(index: 1),
          routeType: 'tab',
          icon: const Icon(CupertinoIcons.chat_bubble_2, color: Colors.white),
          iconContainerColor: KbinColors().fromHex('556880')),
      MenuItem(
          title: AppLocalizations.of(context)!.posts,
          route: SceneRoute(index: 2),
          routeType: 'tab',
          icon: const Icon(CupertinoIcons.text_badge_plus, color: Colors.white),
          iconContainerColor: KbinColors().fromHex('556880')),
      MenuItem(
          title: AppLocalizations.of(context)!.magazines,
          route: const MagazinesRoute(),
          icon: const Icon(CupertinoIcons.tray_2, color: Colors.white),
          iconContainerColor: KbinColors().fromHex('556880')),
      MenuItem(
          title: AppLocalizations.of(context)!.settings_instances,
          route: const MenuRoute(),
          icon: const Icon(CupertinoIcons.circle_grid_hex, color: Colors.white),
          iconContainerColor: KbinColors().fromHex('556880')),
      MenuItem(
          title: AppLocalizations.of(context)!.search,
          route: SceneRoute(index: 3),
          icon: const Icon(CupertinoIcons.search, color: Colors.white),
          iconContainerColor: Colors.red),
      MenuItem(
        title: AppLocalizations.of(context)!.settings,
        route: const SettingsRoute(),
        icon: const Icon(CupertinoIcons.settings, color: Colors.white),
        iconContainerColor: Colors.grey,
      ),
    ];
  }

  List<MenuItem> getProfileEntries(BuildContext context) {
    return <MenuItem>[
      MenuItem(
        title: AppLocalizations.of(context)!.settings_account_login,
        route: const MenuRoute(),
      ),
      MenuItem(
        title: AppLocalizations.of(context)!.settings_account_register,
        route: const MenuRoute(),
      )
    ];
  }
}
