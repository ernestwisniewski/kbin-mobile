import 'package:flutter/material.dart';
import 'package:kbin_mobile/model/entry_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EntriesProvider provider = EntriesProvider();

    return Scaffold(
        appBar: AppBar(
          title: Text('karab.in'),
        ),
        body: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: FutureBuilder(
              future: provider.fetchEntries(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: EntryCard(snapshot: snapshot),
                        ),
                      )
                    ],
                  );
                }

                return Center(
                  child: Column(
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
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
}

class EntryCard extends StatelessWidget {
  final AsyncSnapshot<List<Entry>> snapshot;

  const EntryCard({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(left: 0, right: 0),
        color: Colors.transparent,
        child: ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              Entry entry = snapshot.data![index];
              return Column(
                children: [
                  ListTile(
                      minVerticalPadding: 30,
                      trailing:
                          Image.network('https://picsum.photos/250?image=9'),
                      tileColor: (index.isEven)
                          ? Colors.transparent
                          : Colors.black.withOpacity(0.5),
                      title: Column(
                        children: [
                          Text(entry.title),
                          Row(
                            children: [
                              const Icon(Icons.comment_outlined, size: 15),
                              Text(entry.comments.toString())
                            ],
                          )
                        ],
                      )),
                ],
              );
            }));
  }
}
