import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_item_model.dart';
import 'package:kbin_mobile/repositories/entries_repository.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';

class EntryScreen extends StatelessWidget {
  final String magazine;
  final int id;

  const EntryScreen(
      {Key? key,
      @PathParam('magazine') required this.magazine,
      @PathParam('id') required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: AppBarTitle(title: magazine, fontSize: 16),
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Udostępnij',
          onPressed: () {
            // handle the press
          },
        )
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: buildEntry(),
      ),
    );
  }

  Widget buildEntry() {
    return FutureBuilder(
      future: (EntriesRepository()).fetchEntry(id),
      builder: (BuildContext context, AsyncSnapshot<EntryItem> snapshot) {
        if (snapshot.hasData) {
          EntryItem entry = snapshot.data!;

          return CustomScrollView(
            slivers: buildSliversList(entry),
          );
        }
        return buildLoadingFull();
      },
    );
  }

  List<Widget> buildSliversList(EntryItem entry) {
    List<Widget> list = [];

    if (entry.image != null) {
      list.add(buildSliverAppBar(entry));
    }

    list.add(buildSliverList(entry));

    return list;
  }

  Widget buildSliverAppBar(EntryItem entry) {
    return SliverAppBar(
      leading: const Divider(),
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          Media().getThumbUrl(entry.image!.filePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget buildSliverList(EntryItem entry) {
  return SliverList(
    delegate: SliverChildListDelegate([
      Container(
          margin: const EdgeInsets.only(left: 0, right: 0),
          child: Column(
            children: [
              buildEntryCard(entry),
              buildActionButtons(entry),
              buildUserInfo(entry),
              buildEntryInfo(entry)
            ],
          )),
    ]),
  );
}

Widget buildEntryCard(EntryItem entry) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15, right: 15, top: 30, bottom: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:20, bottom:20),
                            child: Text(entry.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400)),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildActionButtons(EntryItem entry) {
  return Wrap(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextButton(
                        onPressed: null,
                        child: Column(children: [
                          const Icon(Icons.comment_sharp),
                          Text(entry.comments.toString())
                        ]),
                      )),
                )),
            Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextButton(
                        onPressed: null,
                        child: Column(children: [
                          const Icon(Icons.arrow_upward),
                          Text(entry.uv.toString())
                        ]),
                      )),
                )),
            Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextButton(
                        onPressed: null,
                        child: Column(children: [
                          const Icon(Icons.arrow_downward),
                          Text(entry.dv.toString())
                        ]),
                      )),
                )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: const TextButton(
                        onPressed: null,
                        child: Icon(Icons.share),
                      )),
                )),
            Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: const TextButton(
                        onPressed: null,
                        child: Icon(Icons.explore),
                      )),
                )),
            Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: const TextButton(
                        onPressed: null,
                        child: Icon(Icons.report),
                      )),
                )),
          ],
        ),
      )
    ],
  );
}

buildUserInfo(EntryItem entry) {
  return Container(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    color: Colors.black.withOpacity(0.15),
    // color: Colors.black.withOpacity(0.03),
    child: Padding(
      padding: const EdgeInsets.only(
          left: 15, right: 15, top: 30, bottom: 30),
      child: Row(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: entry.image != null
                    ? Image.network(
                  Media().getThumbUrl(entry.image!.filePath),
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.person),
              )),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.user.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(entry.comments.toString()),
                    ),
                    const Text('obserwujących'),
                  ])
                ],
              ))
        ],
      ),
    ),
  );
}

Widget buildEntryInfo(EntryItem entry) {
  return Wrap(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Expanded(
                child: InkWell(
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextButton(
                        onPressed: null,
                        child: Column(children: [
                          const Icon(Icons.remove_red_eye),
                          Text(entry.comments.toString())
                        ]),
                      )),
                )),
            Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextButton(
                        onPressed: null,
                        child: Column(children: [
                          const Icon(Icons.calendar_today),
                          Text(entry.comments.toString())
                        ]),
                      )),
                )),
          ],
        ),
      )
    ],
  );
}
