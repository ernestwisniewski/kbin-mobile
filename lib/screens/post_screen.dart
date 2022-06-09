import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/post_item_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart' as replies;
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/providers/posts_provider.dart';
import 'package:kbin_mobile/providers/replies_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:kbin_mobile/widgets/reply.dart' as reply;
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
  late SettingsProvider _settings;
  late PostProvider _post;
  late RepliesProvider _replies;

  @override
  void initState() {
    super.initState();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();

    _post = Provider.of<PostProvider>(context, listen: false);
    _post.fetch(widget.id);

    _replies = Provider.of<RepliesProvider>(context, listen: false);
    _replies.setPostId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: FittedBox(
              child: NavBarMiddle(
                  route: const PostsRoute(), magazine: widget.magazine)),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            child: const Icon(CupertinoIcons.back,
                size: 20),
            onPressed: () {
              context.router.pop();
            },
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            child: const Icon(CupertinoIcons.share,
                size: 20),
            onPressed: () {
              Share.share(
                  'https://${_settings.instance}/m/${widget.magazine}/w/${widget.id}');
            },
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
          return CupertinoScrollbar(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                slivers: buildSliverLists(context, state.post),
              ),
            ),
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
          buildItem(context, post, 1),
          const Divider(height: 0),
          buildRepliesList(context)
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
                            ? Media().getImage(
                                Media().getThumbUrl(post.user.avatar!.filePath,
                                    settings.instance),
                                null,
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

  Widget buildRepliesList(BuildContext context) {
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
          }

          return Material(
            type: MaterialType.transparency,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                child: const Text('brak odpowiedzi')),
          );
        }

        return buildLoadingFull();
      },
    );
  }

  Future<List<ReplyCollectionItem>> _refresh() async {
    _post.fetch(widget.id);
    return _replies.fetch();
  }
}
