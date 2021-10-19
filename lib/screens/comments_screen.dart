import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/providers/comments_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late SettingsProvider settings;

  @override
  void initState() {
    super.initState();

    settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();

    final comments = Provider.of<CommentsProvider>(context, listen: false);
    comments.fetch();
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
                      Provider.of<CommentsProvider>(context, listen: false)),
                  sortOptions(context,
                      Provider.of<CommentsProvider>(context, listen: false))
                ],
              )),
          child: buildBody(context),
        );
      },
      tabBar: buildBottomNavbar(context, 1),
    );
  }
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
          return Material(
            type: MaterialType.transparency,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                child: const Text('brak komentarzy')),
          );
        }
      }

      return buildLoadingFull();
    },
  );
}

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
                      ? Image.network(
                          Media().getThumbUrl(
                              comment.user.avatar!.filePath, settings.instance!),
                          fit: BoxFit.cover,
                        )
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
