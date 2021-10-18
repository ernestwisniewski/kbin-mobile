import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/providers/search_provider.dart';
import 'package:kbin_mobile/screens/comments_screen.dart' as comment_screen;
import 'package:kbin_mobile/screens/entries_screen.dart' as entries_screen;
import 'package:kbin_mobile/screens/magazines_screen.dart' as magazines_screen;
import 'package:kbin_mobile/screens/post_screen.dart' as post_screen;
import 'package:kbin_mobile/screens/posts_screen.dart' as posts_screen;
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _query;

  _changeQuery(query) {
    setState(() {
      _query = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              middle: const AppBarTitle(),
              leading: buildAppBarLeading(context)),
          child: buildBody(context),
        );
      },
      tabBar: buildBottomNavbar(context, 3),
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
            return ListView.builder(
                itemCount: state.results.length,
                itemBuilder: (BuildContext context, int index) {
                  var subject = state.results[index];
                  return buildSubject(context, subject, index);
                });
          } else {
            return Material(
              type: MaterialType.transparency,
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  child: const Text('brak wyników')),
            );
          }
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
      return entries_screen.buildItem(context, subject, index);
    } else if (subject is CommentCollectionItem) {
      return comment_screen.buildItem(context, subject, index);
    } else if (subject is PostCollectionItem) {
      return posts_screen.buildItem(context, subject, index);
    } else if (subject is ReplyCollectionItem) {
      return post_screen.buildReply(context, subject, index);
    } else if (subject is MagazineCollectionItem) {
      return magazines_screen.buildItem(context, subject, index);
    }

    return Container();
  }
}
