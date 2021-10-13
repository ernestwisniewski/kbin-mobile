import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/providers/comments_provider.dart';
import 'package:kbin_mobile/repositories/comments_repository.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    super.initState();
    final comments = Provider.of<CommentsProvider>(context, listen: false);
    comments.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context),
        bottomNavigationBar: buildBottomNavbar(context, 1));
  }
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    leading: buildAppBarLeading(context),
    actions: [
      IconButton(
        icon: const Icon(Icons.more_vert),
        tooltip: 'Sortuj',
        onPressed: () => showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Anuluj'),
            ),
            title: const Text('Sortuj'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('Ważne'),
                onPressed: () {
                  Provider.of<CommentsProvider>(context, listen: false)
                      .setSortOptions(SortOptions.top);
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Wschodzące'),
                onPressed: () {
                  Provider.of<CommentsProvider>(context, listen: false)
                      .setSortOptions(SortOptions.hot);
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Aktywne'),
                onPressed: () {
                  Provider.of<CommentsProvider>(context, listen: false)
                      .setSortOptions(SortOptions.active);
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Najnowsze'),
                onPressed: () {
                  Provider.of<CommentsProvider>(context, listen: false)
                      .setSortOptions(SortOptions.newest);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      )
    ],
    title: const AppBarTitle(),
  );
}

Widget buildBody(BuildContext context) {
  return SafeArea(
    child: buildCommentList(context),
  );
}

Widget buildCommentList(BuildContext context) {
  return Consumer<CommentsProvider>(
    builder: (context, state, child) {
      if (!state.loading) {
        if (state.comments.isNotEmpty) {
          return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (BuildContext context, int index) {
                CommentCollectionItem comment = state.comments[index];
                return buildItem(context, comment, index);
              });
        } else {
          // Empty list
        }
      }

      return buildLoadingFull();
    },
  );
}

Widget buildItem(
    BuildContext context, CommentCollectionItem comment, int index) {
  return InkWell(
    onTap: () {
      context.router.push(
          EntryRoute(id: comment.entry.id, magazine: comment.magazine.name));
    },
    child: Container(
      color: index.isEven
          ? (KbinColors()).getEvenBackground(context)
          : Colors.transparent,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: comment.user.avatar != null
                  ? Image.network(
                      Media().getThumbUrl(comment.user.avatar!.filePath),
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person),
            )),
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
              buildMetaItem(comment.uv.toString(), Icons.arrow_upward),
              buildMetaItem(comment.dv.toString(), Icons.arrow_downward),
              buildMetaItem(comment.magazine.name, Icons.bookmark)
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
  );
}
