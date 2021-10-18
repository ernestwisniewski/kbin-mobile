import 'package:auto_route/auto_route.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/repositories/magazines_repository.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';

class MagazinesScreen extends StatelessWidget {
  const MagazinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: const AppBarTitle(),
          leading: buildAppBarLeading(context),
          trailing: Material(
            type: MaterialType.transparency,
            child: IconButton(
              color: KbinColors().getAppBarTextColor(),
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
              tooltip: 'Sortuj',
              onPressed: () {
                // handle the press
              },
            ),
          )),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: buildPostList(context),
    );
  }

  Widget buildPostList(BuildContext context) {
    return FutureBuilder(
      future: (MagazinesRepository()).fetchMagazines(),
      builder: (BuildContext context,
          AsyncSnapshot<List<MagazineCollectionItem>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                MagazineCollectionItem magazine = snapshot.data![index];
                return buildItem(context, magazine, index);
              });
        }

        return buildLoadingFull();
      },
    );
  }
}

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
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: magazine.image != null
                        ? Image.network(
                            Media().getMagazineThumbUrl(magazine.image!.filePath),
                            width: 90)
                        : Container()),
                Expanded(
                    flex: magazine.image != null ? 3 : 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        children: [
                          Text(magazine.title,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center),
                          Text('/m/' + magazine.name,
                              style: const TextStyle(color: Colors.grey)),
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
                              'Subskrypcje',
                              magazine.subscriptionsCount.toString(),
                              const EntriesRoute(),
                              1),
                          _listTile(
                              context,
                              'Treści',
                              magazine.entryCount.toString(),
                              const EntriesRoute(),
                              2),
                          _listTile(
                              context,
                              'Komentarze',
                              magazine.entryCommentCount.toString(),
                              const CommentsRoute(),
                              3),
                          _listTile(
                              context,
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
                      ),
                    )),
              ])
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _listTile(BuildContext context, String title, String value,
    PageRouteInfo route, int index) {
  return Container(
    color: index.isEven
        ? (KbinColors()).getEvenBackground(context)
        : Colors.transparent,
    child: ListTile(
      onTap: () {
        context.router.push(route);
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
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                CupertinoIcons.back,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
