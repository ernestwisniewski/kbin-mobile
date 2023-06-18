import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'meta_item.dart';

Widget buildItem(BuildContext context, ReplyCollectionItem reply, int index) {
  return Material(
    type: MaterialType.transparency,
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        decoration: BoxDecoration(
            color: index.isEven
                ? KbinColors().getEvenBackground(context)
                : Colors.transparent,
            border: Border(
              left:
                  BorderSide(width: 2, color: KbinColors().fromHex('#71ac53')),
            )),
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
                        child: reply.user.avatar != null
                            ? Media().getImage(
                                Media().getThumbUrl(reply.user.avatar!.filePath,
                                    settings.instance),
                                BoxFit.cover,
                                null)
                            : const Icon(CupertinoIcons.person_alt)));
              }),
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(reply.user.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: buildMetaItem(reply.uv.toString(),
                                  CupertinoIcons.up_arrow)),
                        ],
                      ),
                      Text(timeago.format(reply.createdAt, locale: 'en'),
                          style: const TextStyle(color: Colors.grey))
                    ],
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(reply.body),
            )
          ],
        ),
      ),
    ),
  );
}
