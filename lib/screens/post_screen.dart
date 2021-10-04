import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_item_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/repositories/posts_repository.dart';
import 'package:kbin_mobile/repositories/replies_repository.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostScreen extends StatelessWidget {
  final int id;
  final String magazine;

  const PostScreen(
      {Key? key,
      @PathParam('magazine') required this.magazine,
      @PathParam('id') required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, id, magazine),
        body: buildBody(context, id));
  }
}

PreferredSizeWidget buildAppBar(BuildContext context, int id, String magazine) {
  return AppBar(
    title: AppBarTitle(title: magazine, fontSize: 16),
    actions: [
      IconButton(
        icon: const Icon(Icons.share),
        tooltip: 'Udostępnij',
        onPressed: () {
          // handle the press
        },
      )
    ],
  );
}

Widget buildBody(BuildContext context, int id) {
  return SafeArea(
    child: buildPost(context, id),
  );
}

Widget buildPost(BuildContext context, int id) {
  return FutureBuilder(
    future: (PostsRepository()).fetchPost(id),
    builder: (BuildContext context, AsyncSnapshot<PostItem> snapshot) {
      if (snapshot.hasData) {
        PostItem post = snapshot.data!;
        return CustomScrollView(
          slivers: buildSliverLists(context, post),
        );
      }
      return buildLoadingFull();
    },
  );
}

List<Widget> buildSliverLists(BuildContext context, PostItem post) {
  return [
    SliverList(
      delegate: SliverChildListDelegate([
        Container(
            margin: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
              children: [
                buildPostItem(context, post, 1),
                const Divider(height:0),
                buildPostRepliesList(context, post.id)
              ],
            )),
      ]),
    )
  ];
}

Widget buildPostItem(BuildContext context, PostItem post, int index) {
  return Container(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: post.user.avatar != null
                      ? Image.network(
                          Media().getThumbUrl(post.user.avatar!.filePath),
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person))),
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(post.user.username,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: buildMetaItem(
                              post.uv.toString(), Icons.arrow_upward)),
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
            buildMetaItem(post.replies.toString(), Icons.comment),
          ]),
        ),
      ],
    ),
  );
}

Widget buildPostRepliesList(BuildContext context, int postId) {
  return FutureBuilder(
    future: (RepliesRepository()).fetchPostReplies(postId),
    builder:
        (BuildContext context, AsyncSnapshot<List<PostReplyItem>> snapshot) {
      if (snapshot.hasData) {
        int index = 0;
        return Column(
          children: [
            for (PostReplyItem item in snapshot.data!)
              buildReply(context, item, index++),
          ],
        );
      }

      return buildLoadingFull();
    },
  );
}

Widget buildReply(BuildContext context, PostReplyItem reply, int index) {
  return Padding(
    padding: const EdgeInsets.only(left:15),
    child: Container(
      decoration: BoxDecoration(
          color: index.isEven
              // ? Colors.black.withOpacity(0.03)
          ? Colors.black.withOpacity(0.15)
              : Colors.transparent,
          border: Border(
            left: BorderSide(width: 2, color: KbinColors().fromHex('#71ac53')),
          )),

      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: reply.user.avatar != null
                        ? Image.network(
                            Media().getThumbUrl(reply.user.avatar!.filePath),
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.person))),
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(reply.user.username,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: buildMetaItem(
                                reply.uv.toString(), Icons.arrow_upward)),
                      ],
                    ),
                    Text(timeago.format(reply.createdAt, locale: 'pl'),
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
  );
}
