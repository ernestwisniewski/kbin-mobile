import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/repositories/magazines_repository.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/magazine.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class MagazinesScreen extends StatefulWidget {
  const MagazinesScreen({Key? key}) : super(key: key);

  @override
  _MagazinesScreenState createState() => _MagazinesScreenState();
}

class _MagazinesScreenState extends State<MagazinesScreen> {
  late SettingsProvider settings;

  @override
  void initState() {
    super.initState();

    settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: const TopBar(),
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
