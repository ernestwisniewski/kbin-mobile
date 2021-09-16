import 'package:flutter/material.dart';
import 'package:kbin_mobile/widgets/menu.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MenuItem> main = Menu().getMainEntries();
    List<MenuItem> profile = Menu().getProfileEntries();

    return Scaffold(
      appBar: AppBar(
        title: Text('karab.in'),
      ),
      body: ListView(
        children: <Widget>[
          ListView.separated(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: main.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        color: main[index].iconContainerColor,
                        shape: BoxShape.circle),
                    child: main[index].icon
                    // @todo
                    ),
                title: Text(main[index].title),
                subtitle: Text(main[index].subtitle ?? ''),
                enabled: (main[index].title == 'Subskrybowane' ||
                    main[index].title == 'Moderowane'
                    ? false
                    : true),
                // @todo
                onTap: () {
                  Navigator.popAndPushNamed(
                      context, main[index].route);
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
            itemCount: profile.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(profile[index].title),
                onTap: () {
                  Navigator.pushNamed(context, profile[index].route);
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
