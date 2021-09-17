import 'package:flutter/material.dart';
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('/m/' + entry.magazine.name, style: TextStyle(color: Colors.grey),),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Text(entry.title,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
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
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Row(children: [
            const Icon(Icons.arrow_upward, size: 15, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: Text(
                entry.uv.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const Icon(Icons.arrow_downward, size: 15, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: Text(
                entry.dv.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const Icon(Icons.comment_outlined, size: 15, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: Text(
                entry.comments.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const Icon(Icons.person, size: 15, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: Text(
                entry.user.username,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            )
          ])
        ],
      ),
    );
  }
}
