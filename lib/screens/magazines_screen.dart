import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/repositories/magazines_repository.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/magazine.dart';
import 'package:kbin_mobile/widgets/nav_bar_leading.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:provider/provider.dart';

class MagazinesScreen extends StatefulWidget {
  const MagazinesScreen({Key? key}) : super(key: key);

  @override
  _MagazinesScreenState createState() => _MagazinesScreenState();
}

class _MagazinesScreenState extends State<MagazinesScreen> {
  late SettingsProvider _settings;

  @override
  void initState() {
    super.initState();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: const FittedBox(child: NavBarMiddle(title: 'Magazyny')),
          leading: buildNavBarLeading(context)),
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
          return CupertinoScrollbar(
            isAlwaysShown: false,
            child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  MagazineCollectionItem magazine = snapshot.data![index];
                  return buildItem(context, magazine, index);
                }),
          );
        }

        return buildLoadingFull();
      },
    );
  }
}
