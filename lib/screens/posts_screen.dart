import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/repositories/posts_repository.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/screens/post_screen.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      alignment: Alignment.centerLeft,
      icon: const Icon(Icons.menu),
      tooltip: 'Przejdź do menu',
      onPressed: () {
        context.router.replace(const MenuRoute());
      },
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.more_vert),
        tooltip: 'Sortuj',
        onPressed: () {
          // handle the press
        },
      )
    ],
    title: const AppBarTitle(),
  );
}

Widget buildBody(BuildContext context) {
  return SafeArea(
    child: buildPostList(context),
  );
}

Widget buildPostList(BuildContext context) {
  return FutureBuilder(
    future: (PostsRepository()).fetchPosts(),
    builder: (BuildContext context,
        AsyncSnapshot<List<PostCollectionItem>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              PostCollectionItem post = snapshot.data![index];
              return buildItem(context, post, index);
            });
      }

      return buildLoadingFull();
    },
  );
}

Widget buildItem(BuildContext context, PostCollectionItem post, int index) {
  int i = 0;
  return Column(
    children: [      const Divider(height: 0),
      InkWell(
        onTap: () {
          context.router.push(PostRoute(id: post.id, magazine: post.magazine.name));
        },
        child: Container(
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
                  buildMetaItem(post.magazine.name, Icons.bookmark),
                ]),
              ),
            ],
          ),
        ),
      ),
      const Divider(height: 0),
      for (PostReplyItem item in post.bestReplies!)
        buildReply(context, item, i++),
    ],
  );
}
