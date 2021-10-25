import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/providers/comments_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/comment.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/nav_bar_leading.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late SettingsProvider _settings;
  late CommentsProvider _comments;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();

    _comments = Provider.of<CommentsProvider>(context, listen: false);
    _comments.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: const FittedBox(
            child: NavBarMiddle(
                route: CommentsRoute(), provider: CommentsProvider),
          ),
          leading: buildNavBarLeading(context),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              timeOptions(context, _comments),
              sortOptions(context, _comments)
            ],
          )),
      child: buildBody(context),
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
            return CupertinoScrollbar(
              controller: _controller,
              isAlwaysShown: false,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: state.comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      CommentCollectionItem comment = state.comments[index];
                      return buildItem(context, comment, index);
                    }),
              ),
            );
          }

          return Material(
            type: MaterialType.transparency,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                child: const Text('brak komentarzy')),
          );
        }

        return buildLoadingFull();
      },
    );
  }

  Future<List<CommentCollectionItem>> _refresh() async {
    return _comments.fetch();
  }
}
