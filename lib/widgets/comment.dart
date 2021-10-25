import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'meta_item.dart';

Widget buildItem(
    BuildContext context, CommentCollectionItem comment, int index) {
  return Material(
    type: MaterialType.transparency,
    child: InkWell(
      onTap: () {
        context.router.push(
            EntryRoute(id: comment.entry.id, magazine: comment.magazine.name));
      },
      child: Container(
        color: index.isEven
            ? (KbinColors()).getEvenBackground(context)
            : Colors.transparent,
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Consumer<SettingsProvider>(builder: (context, settings, child) {
                return Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: comment.user.avatar != null
                      ? Media().getImage(Media().getThumbUrl(
                          comment.user.avatar!.filePath, settings.instance!), BoxFit.cover, null)
                      : const Icon(CupertinoIcons.person_alt),
                ));
              }),
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.user.username,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(timeago.format(comment.createdAt, locale: 'pl'),
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(comment.body),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Wrap(children: [
                buildMetaItem(comment.uv.toString(), CupertinoIcons.up_arrow),
                buildMetaItem(comment.dv.toString(), CupertinoIcons.down_arrow),
                buildMetaItem(comment.magazine.name, CupertinoIcons.bookmark)
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Wrap(children: [
                buildMetaItem(comment.entry.title, null),
              ]),
            )
          ],
        ),
      ),
    ),
  );
}
