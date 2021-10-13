import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_item_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/providers/entry_comments_provider.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class EntryScreen extends StatefulWidget {
  final String magazine;
  final int id;

  const EntryScreen(
      {Key? key,
      @PathParam('magazine') required this.magazine,
      @PathParam('id') required this.id})
      : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();

    final post = Provider.of<EntryProvider>(context, listen: false);
    post.fetch(widget.id);

    final comments = Provider.of<EntryCommentsProvider>(context, listen: false);
    comments.setEntryId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, widget.magazine),
        body: buildBody(context));
  }
}

PreferredSizeWidget buildAppBar(BuildContext context, String magazine) {
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

Widget buildBody(BuildContext context) {
  return SafeArea(
    child: buildEntry(context),
  );
}

Widget buildEntry(BuildContext context) {
  return Consumer<EntryProvider>(
    builder: (context, state, child) {
      if (!state.loading) {
        return CustomScrollView(
          slivers: buildSliverLists(context, state.entry),
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
              buildEntryCard(context, entry),
              buildActionButtons(entry),
              buildUserInfo(context, entry),
              buildEntryInfo(entry),
              buildEntryCommentList(context)
            ],
          )),
    ]),
  );
}

Widget buildEntryCard(BuildContext context, EntryItem entry) {
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
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ))
                ],
              ),
              entry.body != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(entry.body.toString(),
                          style: Theme.of(context).textTheme.bodyText1),
                    )
                  : Container()
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

Widget buildUserInfo(BuildContext context, EntryItem entry) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
      color: (KbinColors()).getEvenBackground(context),
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
                      child: Text(entry.comments.toString(),
                          style: const TextStyle(color: Colors.grey)),
                    ),
                    const Text('obserwujących',
                        style: TextStyle(color: Colors.grey)),
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
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            entry.domain != null
                ? buildActionButton(
                    const Icon(Icons.public), entry.domain!.name, () {})
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
                    child: Text(label, textAlign: TextAlign.center),
                  )
                : Container()
          ]),
        )),
  ));
}

Widget buildEntryCommentList(BuildContext context) {
  return Consumer<EntryCommentsProvider>(
    builder: (context, state, child) {
      if (state.comments.isNotEmpty) {
        int index = 0;
        return Container(
            margin: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
              children: [
                for (EntryCommentsItem item in state.comments)
                  buildComment(context, item, index++),
              ],
            ));
      }

      return buildLoadingFull();
    },
  );
}

Widget buildComment(
    BuildContext context, EntryCommentsItem comment, int index) {
  return Container(
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
