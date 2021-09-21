import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_model.dart';
import 'package:kbin_mobile/repositories/entries_provider.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/entry_action_buttons.dart';
import 'package:kbin_mobile/widgets/entry_card.dart';

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
    EntriesRepository repo = EntriesRepository();

    return Scaffold(
        appBar: AppBar(
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
        ),
        body: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: FutureBuilder(
              future: repo.fetchEntry(id),
              builder: (BuildContext context, AsyncSnapshot<Entry> snapshot) {
                if (snapshot.hasData) {
                  Entry entry = snapshot.data!;
                  return CustomScrollView(
                    slivers: _getSliversList(entry),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          color: KbinColors().fromHex('556880')),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  List<Widget> _getSliversList(Entry entry) {
    List<Widget> list = [];

    if (entry.image != null) {
      Widget sliverAppBar = SliverAppBar(
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

      list.add(sliverAppBar);
    }

    Widget silverList = SliverList(
      delegate: SliverChildListDelegate([
        Container(
            margin: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
              children: [
                EntryCard(entry: entry),
                ActionButtons(entry: entry),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    // color: Colors.black.withOpacity(0.15),
                    color: Colors.black.withOpacity(0.03),
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
                                      padding:
                                          const EdgeInsets.only(right: 10),
                                      child: Text(entry.comments.toString()),
                                    ),
                                    const Text('obserwujących'),
                                  ])
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Wrap(
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
                )
              ],
            )),
      ]),
    );

    list.add(silverList);

    return list;
  }
}
