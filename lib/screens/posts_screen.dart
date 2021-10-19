import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart' as replies;
import 'package:kbin_mobile/providers/posts_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/screens/post_screen.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late SettingsProvider settings;

  @override
  void initState() {
    super.initState();

    settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();

    final posts = Provider.of<PostsProvider>(context, listen: false);
    posts.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              middle: const TopBar(),
              leading: buildAppBarLeading(context),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  timeOptions(context,
                      Provider.of<PostsProvider>(context, listen: false)),
                  sortOptions(context,
                      Provider.of<PostsProvider>(context, listen: false))
                ],
              )),
          child: buildBody(context),
        );
      },
      tabBar: buildBottomNavbar(context, 2),
    );
  }
}

Widget buildBody(BuildContext context) {
  return SafeArea(
    child: buildPostList(context),
  );
}

Widget buildPostList(BuildContext context) {
  return Consumer<PostsProvider>(
    builder: (context, state, child) {
      if (!state.loading) {
        if (state.posts.isNotEmpty) {
          return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (BuildContext context, int index) {
                PostCollectionItem post = state.posts[index];
                return buildItem(context, post, index);
              });
        } else {
          return Material(
            type: MaterialType.transparency,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                child: const Text('brak wpisów')),
          );
        }
      }

      return buildLoadingFull();
    },
  );
}

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
                .push(PostRoute(id: post.id, magazine: post.magazine.name));
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
                                  ? Image.network(
                                      Media().getThumbUrl(
                                          post.user.avatar!.filePath,
                                          settings.instance!),
                                      fit: BoxFit.cover,
                                    )
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
        for (replies.ReplyCollectionItem item in post.bestReplies!)
          buildReply(context, item, i++),
      ],
    ),
  );
}
