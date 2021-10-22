import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_item_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart' as replies;
import 'package:kbin_mobile/providers/posts_provider.dart';
import 'package:kbin_mobile/providers/replies_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/reply.dart' as reply;
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostScreen extends StatefulWidget {
  final String magazine;
  final int id;

  const PostScreen(
      {Key? key,
      @PathParam('magazine') required this.magazine,
      @PathParam('id') required this.id})
      : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late SettingsProvider settings;

  @override
  void initState() {
    super.initState();

    settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();

    final post = Provider.of<PostProvider>(context, listen: false);
    post.fetch(widget.id);

    final comments = Provider.of<RepliesProvider>(context, listen: false);
    comments.setPostId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: FittedBox(
              child:
                  TopBar(route: const PostsRoute(), magazine: widget.magazine)),
          leading: Material(
            type: MaterialType.transparency,
            child: IconButton(
              color: KbinColors().getAppBarTextColor(),
              alignment: Alignment.centerLeft,
              icon: const Icon(CupertinoIcons.back),
              tooltip: 'Wróć',
              onPressed: () {
                context.router.pop();
              },
            ),
          ),
          trailing: Material(
            type: MaterialType.transparency,
            child: IconButton(
              color: KbinColors().getAppBarTextColor(),
              icon: const Icon(CupertinoIcons.share),
              tooltip: 'Udostępnij',
              onPressed: () {
                Share.share(
                    'https://${settings.instance!}/m/${widget.magazine}/w/${widget.id}');
              },
            ),
          )),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: buildPost(context),
    );
  }

  Widget buildPost(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, state, child) {
        if (!state.loading) {
          return CustomScrollView(
            slivers: buildSliverLists(context, state.post),
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
                  buildItem(context, post, 1),
                  const Divider(height: 0),
                  buildPostRepliesList(context)
                ],
              )),
        ]),
      )
    ];
  }

  Widget buildItem(BuildContext context, PostItem post, int index) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
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
                        child: post.user.avatar != null
                            ? Image.network(
                                Media().getThumbUrl(post.user.avatar!.filePath,
                                    settings.instance!),
                                fit: BoxFit.cover,
                              )
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
                            child: Text(post.user.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: buildMetaItem(
                                  post.uv.toString(), CupertinoIcons.up_arrow)),
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
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostRepliesList(BuildContext context) {
    return Consumer<RepliesProvider>(
      builder: (context, state, child) {
        if (!state.loading) {
          if (state.replies.isNotEmpty) {
            int index = 0;
            return Column(
              children: [
                for (replies.ReplyCollectionItem item in state.replies)
                  reply.buildItem(context, item, index++),
              ],
            );
          } else {
            return Material(
              type: MaterialType.transparency,
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  child: const Text('brak odpowiedzi')),
            );
          }
        }

        return buildLoadingFull();
      },
    );
  }
}
