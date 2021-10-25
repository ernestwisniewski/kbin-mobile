import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/providers/posts_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/nav_bar_leading.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:kbin_mobile/widgets/post.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late ScrollController _controller;
  late SettingsProvider _settings;
  late PostsProvider _posts;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();

    _posts = Provider.of<PostsProvider>(context, listen: false);
    _posts.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: const FittedBox(child: NavBarMiddle(route: PostsRoute())),
          leading: buildNavBarLeading(context),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              timeOptions(context, _posts),
              sortOptions(context, _posts)
            ],
          )),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: buildPostList(context),
    );
  }

  Widget buildPostList(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, state, child) {
        if (!state.loading) {
          if (state.posts.isNotEmpty) {
            return CupertinoScrollbar(
              controller: _controller,
              isAlwaysShown: false,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: state.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      PostCollectionItem post = state.posts[index];
                      return buildItem(context, post, index);
                    }),
              ),
            );
          }

          return Material(
            type: MaterialType.transparency,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                child: const Text('brak wpisów')),
          );
        }

        return buildLoadingFull();
      },
    );
  }

  Future<List<PostCollectionItem>> _refresh() async {
    return _posts.fetch();
  }
}
