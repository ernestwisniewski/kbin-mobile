import 'package:auto_route/auto_route.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/repositories/search_repository.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/screens/post_screen.dart' as post_screen;
import 'package:kbin_mobile/screens/posts_screen.dart' as posts_screen;
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/screens/comments_screen.dart' as commentsScreen;
import 'package:kbin_mobile/screens/entries_screen.dart' as entries_screen;
import 'package:kbin_mobile/screens/magazines_screen.dart' as magazines_screen;

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context),
        bottomNavigationBar: buildBottomNavbar(context, 3));
  }
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

Widget buildBody(BuildContext context) {
  return SafeArea(
    child: buildPostList(context),
  );
}

Widget buildPostList(BuildContext context) {
  return FutureBuilder(
    future: (SearchRepository()).search('rust eventsourcing eventstorming'),
    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              var subject = snapshot.data![index];
              return buildSubject(context, subject, index);
            });
      }

      return buildLoadingFull();
    },
  );
}

Widget buildSubject(BuildContext context, dynamic subject, int index) {
  if (subject is EntryCollectionItem) {
    return entries_screen.buildItem(context, subject, index);
  } else if (subject is CommentCollectionItem) {
    return commentsScreen.buildItem(context, subject, index);
  } else if (subject is PostCollectionItem) {
    return posts_screen.buildItem(context, subject, index);
  } else if (subject is ReplyCollectionItem) {
    return post_screen.buildReply(context, subject, index);
  } else if (subject is MagazineCollectionItem) {
    return magazines_screen.buildItem(context, subject, index);
  }

  return Container();
}
