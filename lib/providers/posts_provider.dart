import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_item_model.dart';
import 'package:kbin_mobile/repositories/posts_repository.dart';

class PostsProvider with ChangeNotifier {
  bool _loading = true;
  int _page = 1;
  List<PostCollectionItem> _posts = [];

  bool get loading => _loading;

  int get page => _page;

  List<PostCollectionItem> get posts => _posts;

  void fetch(int page, SortOptions sortOptions) async {
    _loading = true;
    _posts = await PostsRepository().fetchPosts(page, sortOptions);
    _loading = false;

    notifyListeners();
  }
}

class PostProvider with ChangeNotifier {
  bool _loading = true;

  late PostItem _post;

  bool get loading => _loading;

  PostItem get post => _post;

  void fetch(int id) async {
    _loading = true;
    _post = await PostsRepository().fetchPost(id);
    _loading = false;

    notifyListeners();
  }
}
