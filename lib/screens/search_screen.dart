import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/providers/search_provider.dart';
import 'package:kbin_mobile/widgets/comment.dart' as comment;
import 'package:kbin_mobile/widgets/entry.dart' as entry;
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/magazine.dart' as magazine;
import 'package:kbin_mobile/widgets/nav_bar_leading.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:kbin_mobile/widgets/post.dart' as post;
import 'package:kbin_mobile/widgets/reply.dart' as reply;
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ScrollController _controller;
  String? _query;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
  }

  _changeQuery(query) {
    setState(() {
      _query = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: FittedBox(
              child: NavBarMiddle(title: AppLocalizations.of(context)!.search)),
          leading: buildNavBarLeading(context)),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: buildFloatingSearchBar(context, _query),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: buildResultsList(context, _query),
        )
      ],
    ));
  }

  Widget buildResultsList(BuildContext context, String? _query) {
    return Consumer<SearchProvider>(
      builder: (context, state, child) {
        if (!state.loading) {
          if (state.results.isNotEmpty && _query != null) {
            return CupertinoScrollbar(
              controller: _controller,
              isAlwaysShown: false,
              child: ListView.builder(
                  controller: _controller,
                  itemCount: state.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    var subject = state.results[index];
                    return buildSubject(context, subject, index);
                  }),
            );
          }

          return Material(
            type: MaterialType.transparency,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              child: Text(AppLocalizations.of(context)!.search_no_results),
            ),
          );
        }

        return buildLoadingFull();
      },
    );
  }

  Widget buildFloatingSearchBar(BuildContext context, String? query) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CupertinoSearchTextField(
        onSubmitted: (String q) {
          _changeQuery(q);
          Provider.of<SearchProvider>(context, listen: false).search(q);
        },
      ),
    );
  }

  Widget buildSubject(BuildContext context, dynamic subject, int index) {
    if (subject is EntryCollectionItem) {
      return entry.buildItem(context, subject, index);
    } else if (subject is CommentCollectionItem) {
      return comment.buildItem(context, subject, index);
    } else if (subject is PostCollectionItem) {
      return post.buildItem(context, subject, index);
    } else if (subject is ReplyCollectionItem) {
      return reply.buildItem(context, subject, index);
    } else if (subject is MagazineCollectionItem) {
      return magazine.buildItem(context, subject, index);
    }

    return Container();
  }
}
