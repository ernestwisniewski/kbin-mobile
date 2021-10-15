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
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
    return Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context, _query),
        bottomNavigationBar: buildBottomNavbar(context, 3));
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      leading: buildAppBarLeading(context),
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

  Widget buildBody(BuildContext context, String? _query) {
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
            return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                child: const Text('brak wyników'));
          }
        }

        return buildLoadingFull();
      },
    );
  }

  Widget buildFloatingSearchBar(BuildContext context, String? query) {
    return FloatingSearchBar(
        backdropColor: Colors.transparent,
        hint: 'Wyszukaj...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: 0.0,
        openAxisAlignment: 0.0,
        width: 600,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (q) {
          if (q.isEmpty) {
            return;
          }

          _changeQuery(q);
          Provider.of<SearchProvider>(context, listen: false).search(q);
        },
        transition: CircularFloatingSearchBarTransition(),
        builder: (context, transition) {
          return Container();
        });
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
