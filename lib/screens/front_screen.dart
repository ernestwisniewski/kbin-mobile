import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/model/entry_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EntriesProvider provider = EntriesProvider();

    return Scaffold(
        appBar: AppBar(
          title: const Text('karab.in'),
        ),
        body: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: FutureBuilder(
              future: provider.fetchEntries(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
                if (snapshot.hasData) {
                  return EntryCard(snapshot: snapshot);
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
}

class EntryCard extends StatelessWidget {
  final AsyncSnapshot<List<Entry>> snapshot;

  const EntryCard({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0),
        child: ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              Entry entry = snapshot.data![index];
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        color: index.isEven
                            ? Colors.black.withOpacity(0.3)
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 20),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(entry.title,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Image.network(
                                        'https://picsum.photos/250?image=9',
                                        width: 80),
                                  ),
                                ],
                              ),
                              EntryMeta(entry: entry)

                            ],
                          ),
                        )),
                  ),
                ],
              );
            }));
  }
}

class EntryMeta extends StatelessWidget {
  const EntryMeta({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Row(children: [
            const Icon(Icons.comment_outlined, size: 15, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                entry.comments.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            )
          ])
        ],
      ),
    );
  }
}
