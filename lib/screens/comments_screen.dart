import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/providers/comments_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/comment.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';

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
              middle: const TopBar(
                  route: CommentsRoute(), provider: CommentsProvider),
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
            return Scrollbar(
              showTrackOnHover: true,
              isAlwaysShown: false,
              child: ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    CommentCollectionItem comment = state.comments[index];
                    return buildItem(context, comment, index);
                  }),
            );
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
}
