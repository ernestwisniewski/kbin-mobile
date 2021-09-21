import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/providers/menu_provider.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';

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
          ),
        ],
      ),
    );
  }
}
