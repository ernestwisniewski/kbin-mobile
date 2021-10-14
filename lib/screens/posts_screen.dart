import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart' as replies;
import 'package:kbin_mobile/providers/posts_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/screens/post_screen.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>  {
  @override
  void initState() {
    super.initState();
    final posts = Provider.of<PostsProvider>(context, listen: false);
    posts.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context),
        bottomNavigationBar: buildBottomNavbar(context, 2));
  }
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    leading: buildAppBarLeading(context),
    actions: [
      Row(
        children: [
          timeOptions(context, Provider.of<PostsProvider>(context, listen: false)),
          sortOptions(context, Provider.of<PostsProvider>(context, listen: false)),
        ],
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
          return Container(child: Text('brak komentarzy'));
          // Empty list
        }
      }

      return buildLoadingFull();
    },
  );
}

Widget buildItem(BuildContext context, PostCollectionItem post, int index) {
  int i = 0;
  return Column(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
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
      for (replies.ReplyCollectionItem item in post.bestReplies!)
        buildReply(context, item, i++),
    ],
  );
}
