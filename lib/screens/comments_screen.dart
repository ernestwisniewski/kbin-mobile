import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/repositories/comments_repository.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

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
    child: buildCommentList(context),
  );
}

Widget buildCommentList(BuildContext context) {
  return FutureBuilder(
    future: (CommentsRepository()).fetchComments(),
    builder: (BuildContext context,
        AsyncSnapshot<List<CommentCollectionItem>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              CommentCollectionItem comment = snapshot.data![index];
              return buildItem(context, comment, index);
            });
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
          ? (KbinColors()).getEventBackground(context)
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
