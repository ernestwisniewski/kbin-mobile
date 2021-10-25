import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/helpers/media.dart';
import 'package:kbin_mobile/models/entry_comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_item_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/providers/entry_comments_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/meta_item.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late SettingsProvider _settings;
  late EntryCommentsProvider _comments;
  late EntryProvider _entry;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();

    _entry = Provider.of<EntryProvider>(context, listen: false);
    _entry.fetch(widget.id);

    _comments = Provider.of<EntryCommentsProvider>(context, listen: false);
    _comments.setEntryId(widget.id);
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: FittedBox(
              child: NavBarMiddle(
                  magazine: widget.magazine, route: const EntriesRoute())),
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
                  'https://${_settings.instance!}/m/${widget.magazine}/t/${widget.id}');
            },
          ),
        ),
        child: buildBody(context));
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
          return CupertinoScrollbar(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                slivers: buildSliverLists(context, state.entry),
              ),
            ),
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
    return Consumer<SettingsProvider>(builder: (context, settings, child) {
      return SliverAppBar(
        leading: const Divider(),
        backgroundColor: Colors.transparent,
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
          background: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              fit: BoxFit.fitWidth,
              image: Media()
                  .getThumbUrl(entry.image!.filePath, settings.instance!)),
        ),
      );
    });
  }

  Widget buildSliverList(BuildContext context, EntryItem entry) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Material(
            type: MaterialType.transparency,
            child: buildEntryCard(context, entry)),
        Material(
            type: MaterialType.transparency, child: buildActionButtons(entry)),
        Material(
            type: MaterialType.transparency,
            child: buildUserInfo(context, entry)),
        Material(type: MaterialType.transparency, child: buildEntryInfo(entry)),
        Material(
            type: MaterialType.transparency,
            child: buildEntryCommentList(context)),
      ]),
    );
  }

  Widget buildEntryCard(BuildContext context, EntryItem entry) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: entry.url != null
                ? () {
                    _launched = _launchInBrowser(entry.url!);
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 40, bottom: 40),
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
              buildActionButton(const Icon(CupertinoIcons.chat_bubble_2),
                  entry.comments.toString(), () {}),
              buildActionButton(const Icon(CupertinoIcons.up_arrow),
                  entry.uv.toString(), () {}),
              buildActionButton(const Icon(CupertinoIcons.down_arrow),
                  entry.dv.toString(), () {}),
              buildActionButton(
                  const Icon(Icons.explore_outlined),
                  null,
                  entry.url != null
                      ? () {
                          _launched = _launchInBrowser(entry.url!);
                        }
                      : null),
              buildActionButton(
                  const Icon(CupertinoIcons.xmark_octagon), null, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildUserInfo(BuildContext context, EntryItem entry) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
        color: (KbinColors()).getEvenBackground(context),
        child: Row(
          children: [
            Consumer<SettingsProvider>(builder: (context, settings, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: entry.user.avatar != null
                    ? Media().getImage(
                        Media().getThumbUrl(
                            entry.user.avatar!.filePath, settings.instance!),
                        null,
                        100)
                    : const Icon(Icons.person),
              );
            }),
            Column(
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
            )
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
                  ? buildActionButton(const Icon(CupertinoIcons.globe),
                      entry.domain!.name, null, true)
                  : Container(),
              buildActionButton(
                  const Icon(CupertinoIcons.eye), entry.views.toString()),
              buildActionButton(const Icon(CupertinoIcons.calendar),
                  timeago.format(entry.createdAt, locale: 'pl')),
            ],
          ),
        )
      ],
    );
  }

  Widget buildActionButton(
      [Icon? icon, String? label, GestureTapCallback? fn, bool? fitted]) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CupertinoButton(
              onPressed: fn,
              child: Column(children: [
                icon ?? Container(),
                label != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: fitted ?? false ? FittedBox(
                          child: Text(label,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13)),
                        ) : Text(label,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13)),
                      )
                    : Container()
              ]),
            )));
  }

  Widget buildEntryCommentList(BuildContext context) {
    return Consumer<EntryCommentsProvider>(
      builder: (context, state, child) {
        if (!state.loading) {
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

          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              child: const Text('brak komentarzy'));
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
            Consumer<SettingsProvider>(builder: (context, settings, child) {
              return Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: comment.user.avatar != null
                    ? Media().getImage(
                        Media().getThumbUrl(
                            comment.user.avatar!.filePath, settings.instance!),
                        null,
                        null)
                    : const Icon(Icons.person),
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
              buildMetaItem(comment.uv.toString(), CupertinoIcons.up_arrow),
              buildMetaItem(comment.dv.toString(), CupertinoIcons.down_arrow)
            ]),
          ),
        ],
      ),
    );
  }

  Future<List<EntryCommentsItem>> _refresh() async {
    _entry.fetch(widget.id);
    return _comments.fetch();
  }
}
