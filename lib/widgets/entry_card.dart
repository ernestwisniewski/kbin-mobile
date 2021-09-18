import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_model.dart';

class EntryCard extends StatelessWidget {
  final AsyncSnapshot<List<Entry>> snapshot;

  const EntryCard({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Media media = Media();

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
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0),
                                        child: Text(
                                            '/m/' + entry.magazine.name,
                                            style: const TextStyle(
                                                color: Colors.grey)),
                                      ),
                                      Text(entry.title,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: entry.image != null
                                        ? Image.network(
                                            Media().getThumbUrl(
                                                entry.image!.filePath),
                                            width: 90)
                                        : null,
                                  ),
                                ],
                              ),
                              Row(children: [
                                Expanded(child: EntryMeta(entry: entry))
                              ])
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
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          MetaItem(label: entry.uv.toString(), icon: Icons.arrow_upward),
          MetaItem(label: entry.dv.toString(), icon: Icons.arrow_downward),
          MetaItem(label: entry.comments.toString(), icon: Icons.comment_outlined),
          MetaItem(label: entry.user.username, icon: Icons.person)
        ],
      ),
    );
  }
}

class MetaItem extends StatelessWidget {
  const MetaItem({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 15, color: Colors.grey),
      Padding(
        padding: const EdgeInsets.only(left: 5, right: 15),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
      )
    ]);
  }
}
