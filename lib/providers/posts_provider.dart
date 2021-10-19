import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/filters/stort_options_filters.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_item_model.dart';
import 'package:kbin_mobile/repositories/posts_repository.dart';

class PostsProvider with ChangeNotifier {
  bool _loading = false;
  int _page = 1;
  List<PostCollectionItem> _posts = [];
  SortOptions _sortOptions = SortOptions.hot;
  TimeOptions _timeOptions = TimeOptions.fromall;

  bool get loading => _loading;

  int get page => _page;

  List<PostCollectionItem> get posts => _posts;

  SortOptions get sortOptions => _sortOptions;

  TimeOptions get timeOptions => _timeOptions;

  void setPage(int page) {
    _page = page;
    fetch();
  }

  void setTimeOptions(TimeOptions timeOptions) {
    _timeOptions = timeOptions;
    fetch();
  }

  void setSortOptions(SortOptions sortOptions) {
    _sortOptions = sortOptions;
    fetch();
  }

  void fetch() async {
    _loading = true;
    _posts =
        await PostsRepository().fetchPosts(_page, _sortOptions, _timeOptions);
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
    notifyListeners();

    _post = await PostsRepository().fetchPost(id);
    _loading = false;
    notifyListeners();
  }
}
