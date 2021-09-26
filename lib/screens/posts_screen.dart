import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/repositories/posts_repository.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      alignment: Alignment.centerLeft,
      icon: const Icon(Icons.menu),
      tooltip: 'Przejdź do menu',
      onPressed: () {
        context.router.replace(const MenuRoute());
      },
    ),
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
  print((PostsRepository()).fetchPosts());
  return FutureBuilder(
    future: (PostsRepository()).fetchPosts(),
    builder: (BuildContext context,
        AsyncSnapshot<List<PostCollectionItem>> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              PostCollectionItem post = snapshot.data![index];
              return buildItem(context, post, index);
            });
      }

      return buildLoadingFull();
    },
  );
}

Widget buildItem(BuildContext context, PostCollectionItem post, int index) {
  return Container();
}
