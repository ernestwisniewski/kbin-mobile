import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:provider/provider.dart';

import 'meta_item.dart';

Widget buildItem(BuildContext context, EntryCollectionItem entry,
    [int index = 1]) {
  return Material(
    type: MaterialType.transparency,
    child: Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              context.router.push(
                  EntryRoute(id: entry.id, magazine: entry.magazine.name));
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
    ),
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
      Consumer<SettingsProvider>(builder: (context, settings, child) {
        try {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: entry.image != null
                ? Media().getImage(
                    Media().getEntryThumbUrl(
                        entry.image!.filePath, settings.instance!),
                    null,
                    90)
                : null
          );
        } catch (e) {
          return Container();
        }
      }),
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
          buildMetaItem(entry.uv.toString(), CupertinoIcons.up_arrow),
          buildMetaItem(entry.dv.toString(), CupertinoIcons.down_arrow),
          buildMetaItem(
              entry.comments.toString(), CupertinoIcons.chat_bubble_2),
          buildMetaItem(entry.user.username, CupertinoIcons.person_alt, true)
        ],
      ),
    ))
  ]);
}
