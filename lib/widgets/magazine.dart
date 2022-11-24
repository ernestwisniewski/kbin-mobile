import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/providers/filters_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:provider/provider.dart';

Widget buildItem(
    BuildContext context, MagazineCollectionItem magazine, int index) {
  return Material(
    type: MaterialType.transparency,
    child: Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  buildTitle(context, magazine),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: magazine.description != null
                        ? Text(magazine.description!)
                        : Container(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Divider(),
                  ),
                  _listTile(
                      context,
                      magazine.name,
                      'Subskrypcje',
                      magazine.subscriptionsCount.toString(),
                      const EntriesRoute(),
                      1),
                  _listTile(context, magazine.name, 'Treści',
                      magazine.entryCount.toString(), const EntriesRoute(), 2),
                  _listTile(
                      context,
                      magazine.name,
                      'Komentarze',
                      magazine.entryCommentCount.toString(),
                      const CommentsRoute(),
                      3),
                  _listTile(
                      context,
                      magazine.name,
                      'Mikroblog',
                      (magazine.postCount + magazine.postCommentCount)
                          .toString(),
                      const PostsRoute(),
                      4),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Divider(),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTitle(BuildContext context, MagazineCollectionItem magazine) {
  return Row(
    children: [
      Consumer<SettingsProvider>(builder: (context, settings, child) {
        return Container(
            child: magazine.image != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Media().getImage(
                        Media().getMagazineThumbUrl(
                            magazine.image!.filePath, settings.instance),
                        null,
                        120),
                  )
                : Container());
      }),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(magazine.title, style: Theme.of(context).textTheme.headline6),
            Text('/m/${magazine.name}',
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    ],
  );
}

Widget _listTile(BuildContext context, String magazine, String title,
    String value, PageRouteInfo route, int index) {
  return Container(
    color: index.isEven
        ? (KbinColors()).getEvenBackground(context)
        : Colors.transparent,
    child: ListTile(
      onTap: () {
        FiltersProvider filters =
            Provider.of<FiltersProvider>(context, listen: false);
        filters.setScreenView(magazine);
        context.router.navigate(SceneRoute(route: route));
      },
      dense: true,
      title: Text(title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Badge(
              badgeColor: Theme.of(context).primaryColor,
              elevation: 0,
              shape: BadgeShape.circle,
              padding: const EdgeInsets.all(10),
              badgeContent: Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Icon(
                CupertinoIcons.right_chevron,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
