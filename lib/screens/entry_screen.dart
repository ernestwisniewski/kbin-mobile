import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_item_model.dart';
import 'package:kbin_mobile/repositories/comments_repository.dart';
import 'package:kbin_mobile/repositories/entries_repository.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class EntryScreen extends StatelessWidget {
  final String magazine;
  final int id;

  const EntryScreen(
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
    child: buildEntry(context, id),
  );
}

Widget buildEntry(BuildContext context, int id) {
  return FutureBuilder(
    future: (EntriesRepository()).fetchEntry(id),
    builder: (BuildContext context, AsyncSnapshot<EntryItem> snapshot) {
      if (snapshot.hasData) {
        EntryItem entry = snapshot.data!;

        return CustomScrollView(
          slivers: buildSliverLists(context, entry),
        );
      }
      return buildLoadingFull();
    },
  );
}

List<Widget> buildSliverLists(BuildContext context, EntryItem entry) {
  List<Widget> list = [];

  if (entry.image != null) {
    list.add(buildSliverAppBar(context, entry));
  }

  list.add(buildSliverList(context, entry));

  return list;
}

Widget buildSliverAppBar(BuildContext context, EntryItem entry) {
  return SliverAppBar(
    leading: const Divider(),
    backgroundColor: Colors.transparent,
    expandedHeight: 200,
    flexibleSpace: FlexibleSpaceBar(
      background: Image.network(
        Media().getThumbUrl(entry.image!.filePath),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget buildSliverList(BuildContext context, EntryItem entry) {
  return SliverList(
    delegate: SliverChildListDelegate([
      Container(
          margin: const EdgeInsets.only(left: 0, right: 0),
          child: Column(
            children: [
              buildEntryCard(entry),
              buildActionButtons(entry),
              buildUserInfo(entry),
              buildEntryInfo(entry),
              buildEntryCommentList(context, entry.id)
            ],
          )),
    ]),
  );
}

Widget buildEntryCard(EntryItem entry) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 40),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                    ],
                  ))
                ],
              ),
              entry.body != null ? Padding(
                padding: const EdgeInsets.only(top:40),
                child: Text(entry.body.toString()),
              ) : Container()
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildActionButtons(EntryItem entry) {
  return Wrap(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Row(
          children: [
            buildActionButton(const Icon(Icons.comment_sharp),
                entry.comments.toString(), () {}),
            buildActionButton(
                const Icon(Icons.arrow_upward), entry.uv.toString(), () {}),
            buildActionButton(
                const Icon(Icons.arrow_downward), entry.dv.toString(), () {}),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            buildActionButton(const Icon(Icons.share), null, () {}),
            buildActionButton(const Icon(Icons.explore), null, () {}),
            buildActionButton(const Icon(Icons.report), null, () {}),
          ],
        ),
      )
    ],
  );
}

Widget buildUserInfo(EntryItem entry) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
      color: Colors.black.withOpacity(0.15),
      // color: Colors.black.withOpacity(0.03),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: entry.user.avatar != null
                ? Image.network(
                    Media().getThumbUrl(entry.user.avatar!.filePath),
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.person),
          )),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.user.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18)),
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(entry.comments.toString()),
                    ),
                    const Text('obserwujących'),
                  ])
                ],
              ))
        ],
      ),
    ),
  );
}

Widget buildEntryInfo(EntryItem entry) {
  return Wrap(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom:30, top:15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            entry.domain != null
                ? buildActionButton(const Icon(Icons.public), entry.domain!.name, (){})
                : Container(),
            buildActionButton(
                const Icon(Icons.remove_red_eye), entry.views.toString()),
            buildActionButton(const Icon(Icons.calendar_today),
                timeago.format(entry.createdAt, locale: 'pl')),
          ],
        ),
      )
    ],
  );
}

Widget buildActionButton([Icon? icon, String? label, GestureTapCallback? fn]) {
  return Expanded(
      child: InkWell(
    onTap: fn,
    child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextButton(
          onPressed: null,
          child: Column(children: [
            icon ?? Container(),
            label != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(label),
                  )
                : Container()
          ]),
        )),
  ));
}

Widget buildEntryCommentList(BuildContext context, int entryId) {
  return FutureBuilder(
    future: (CommentsRepository()).fetchEntryComments(entryId),
    builder: (BuildContext context,
        AsyncSnapshot<List<EntryCommentsItem>> snapshot) {
      if (snapshot.hasData) {
        int index = 0;
        return Container(
            margin: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
              children: [
                for (EntryCommentsItem item in snapshot.data!)
                  buildComment(context, item, index++),
              ],
            ));
      }

      return buildLoadingFull();
    },
  );
}

Widget buildComment(BuildContext context, EntryCommentsItem comment, int index) {
  return Container(
    color: index.isEven
        // ? Colors.black.withOpacity(0.03)
    ? Colors.black.withOpacity(0.15)
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
                      style: const TextStyle(color: Colors.grey))
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
            buildMetaItem(comment.dv.toString(), Icons.arrow_downward)
          ]),
        ),
      ],
    ),
  );
}