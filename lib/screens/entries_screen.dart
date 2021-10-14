import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:provider/provider.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  @override
  void initState() {
    super.initState();
    final entry = Provider.of<EntriesProvider>(context, listen: false);
    entry.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context),
        bottomNavigationBar: buildBottomNavbar(context, 0));
  }
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    leading: buildAppBarLeading(context),
    actions: [
      Row(
        children: [
          timeOptions(context, Provider.of<EntriesProvider>(context, listen: false)),
          sortOptions(context, Provider.of<EntriesProvider>(context, listen: false)),
        ],
      ),
    ],
    title: const AppBarTitle(),
  );
}

Widget buildBody(BuildContext context) {
  return SafeArea(
    child: buildEntryList(context),
  );
}

Widget buildEntryList(BuildContext context) {
  return Consumer<EntriesProvider>(
    builder: (context, state, child) {
      if (!state.loading) {
        if (state.entries.isNotEmpty) {
          return ListView.builder(
              itemCount: state.entries.length,
              itemBuilder: (BuildContext context, int index) {
                EntryCollectionItem entry = state.entries[index];
                return buildItem(context, entry, index);
              });
        } else {
          return Container(child: Text('brak treści'));
          // Empty list
        }
      }

      return buildLoadingFull();
    },
  );
}

Widget buildItem(BuildContext context, EntryCollectionItem entry,
    [int index = 1]) {
  return Row(
    children: <Widget>[
      Expanded(
        child: InkWell(
          onTap: () {
            context.router
                .push(EntryRoute(id: entry.id, magazine: entry.magazine.name));
          },
          child: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 20),
              color: index.isEven
                  ? (KbinColors()).getEvenBackground(context)
                  : Colors.transparent,
              child: Column(
                children: [
                  buildMain(context, entry),
                  buildMeta(context, entry),
                ],
              )),
        ),
      ),
    ],
  );
}

Widget buildMain(BuildContext context, EntryCollectionItem entry) {
  return Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('/m/' + entry.magazine.name,
                style: const TextStyle(color: Colors.grey)),
          ),
          Text(entry.title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      )),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: entry.image != null
            ? Image.network(Media().getThumbUrl(entry.image!.filePath),
                width: 90)
            : null,
      ),
    ],
  );
}

Widget buildMeta(BuildContext context, EntryCollectionItem entry) {
  return Row(children: [
    Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Wrap(
        children: [
          buildMetaItem(entry.uv.toString(), Icons.arrow_upward),
          buildMetaItem(entry.dv.toString(), Icons.arrow_downward),
          buildMetaItem(entry.comments.toString(), Icons.comment_outlined),
          buildMetaItem(entry.user.username, Icons.person, true)
        ],
      ),
    ))
  ]);
}
