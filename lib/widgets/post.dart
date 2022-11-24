import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart' as replies;
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/reply.dart' as reply;
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget buildItem(BuildContext context, PostCollectionItem post, int index) {
  int i = 0;
  return Material(
    type: MaterialType.transparency,
    child: Column(
      children: [
        const Divider(height: 0),
        InkWell(
          onTap: () {
            context.router
                .navigate(PostRoute(id: post.id, magazine: post.magazine.name));
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Consumer<SettingsProvider>(
                    builder: (context, settings, child) {
                      return Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: post.user.avatar != null
                                  ? Media().getImage(
                                      Media().getThumbUrl(
                                          post.user.avatar!.filePath,
                                          settings.instance),
                                      BoxFit.cover,
                                      null)
                                  : const Icon(CupertinoIcons.person_alt)));
                    },
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(post.user.username,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: buildMetaItem(post.uv.toString(),
                                      CupertinoIcons.up_arrow)),
                            ],
                          ),
                          Text(timeago.format(post.createdAt, locale: 'pl'),
                              style: const TextStyle(color: Colors.grey))
                        ],
                      )),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(post.body),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Wrap(children: [
                    buildMetaItem(
                        post.replies.toString(), CupertinoIcons.chat_bubble_2),
                    buildMetaItem(post.magazine.name, CupertinoIcons.bookmark),
                  ]),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 0),
        for (replies.ReplyCollectionItem item in post.bestReplies)
          reply.buildItem(context, item, i++),
      ],
    ),
  );
}
