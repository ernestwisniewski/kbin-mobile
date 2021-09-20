import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/entry_card.dart';

class EntryScreen extends StatelessWidget {
  final String magazine;
  final int id;

  const EntryScreen({Key? key,
    @PathParam('magazine') required this.magazine,
    @PathParam('id') required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EntriesProvider provider = EntriesProvider();

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
              future: provider.fetchEntry(id),
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
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextButton(
                                onPressed: null,
                                child: Column(children: [
                                  const Icon(Icons.comment_sharp),
                                  Text(entry.comments.toString())
                                ]),
                              ))),
                      Expanded(
                          child: Container(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextButton(
                                onPressed: null,
                                child: Column(children: [
                                  const Icon(Icons.arrow_upward),
                                  Text(entry.uv.toString())
                                ]),
                              ))),
                      Expanded(
                          child: Container(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextButton(
                                onPressed: null,
                                child: Column(children: [
                                  const Icon(Icons.arrow_downward),
                                  Text(entry.dv.toString())
                                ]),
                              ))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              child: const TextButton(
                                onPressed: null,
                                child: Icon(Icons.share),
                              ))),
                      Expanded(
                          child: Container(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              child: const TextButton(
                                onPressed: null,
                                child: Icon(Icons.explore),
                              ))),
                      Expanded(
                          child: Container(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              child: const TextButton(
                                onPressed: null,
                                child: Icon(Icons.report),
                              ))),
                    ],
                  ),
                ),
                //  const Padding(
                //   padding:
                //       EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                //   child: Align(
                //       alignment: Alignment.topLeft,
                //       child:
                //           Text('Komentrze:', style: TextStyle(fontSize: 22))),
                // ),
              ],
            )),
      ]),
    );

    list.add(silverList);

    return list;
  }
}
