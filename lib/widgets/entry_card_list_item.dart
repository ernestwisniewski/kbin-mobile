import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_model.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

class EntryCardListItem extends StatelessWidget {
  final Entry entry;
  final int index;

  const EntryCardListItem({Key? key, required this.entry, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                  EntryRoute(id: entry.id, magazine: entry.magazine.name));
            },
            child: Container(
                color: index.isEven
                    ? Colors.black.withOpacity(0.03)
                    // ? Colors.black.withOpacity(0.15)
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text('/m/' + entry.magazine.name,
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                              Text(entry.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: entry.image != null
                                ? Image.network(
                                    Media().getThumbUrl(entry.image!.filePath),
                                    width: 90)
                                : null,
                          ),
                        ],
                      ),
                      Row(children: [Expanded(child: EntryMeta(entry: entry))])
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
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
      child: Wrap(
        children: [
          MetaItem(label: entry.uv.toString(), icon: Icons.arrow_upward),
          MetaItem(label: entry.dv.toString(), icon: Icons.arrow_downward),
          MetaItem(
              label: entry.comments.toString(), icon: Icons.comment_outlined),
          MetaItem(label: entry.user.username, icon: Icons.person, highlighted: true)
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
    this.highlighted = false
  }) : super(key: key);

  final String label;
  final IconData icon;
  final bool? highlighted;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Icon(icon, size: 15, color: Colors.grey),
      Padding(
        padding: const EdgeInsets.only(left: 5, right: 15),
        child: Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: highlighted! == true ? FontWeight.w600 : FontWeight.normal),
        ),
      )
    ]);
  }
}
