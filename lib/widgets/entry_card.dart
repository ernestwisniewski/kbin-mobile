import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_model.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;

  const EntryCard({Key? key, required this.entry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
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
                        Text(entry.title,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    )),
                  ],
                ),
                Row(children: [Expanded(child: EntryMeta(entry: entry))])
              ],
            ),
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
      child: Row(
        children: [
          MetaItem(
              label: entry.comments.toString(), icon: Icons.comment_outlined),
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
