import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/repositories/replies_repository.dart';

class RepliesProvider with ChangeNotifier {
  bool _loading = false;
  int _page = 1;
  late int _postId;
  List<ReplyCollectionItem> _replies = [];
  SortOptions _sortOptions = SortOptions.hot;

  bool get loading => _loading;

  int get page => _page;

  List<ReplyCollectionItem> get replies => _replies;

  SortOptions get sortOptions => _sortOptions;

  void setPostId(int postId) {
    _postId = postId;
    fetch();
  }

  void setPage(int page) {
    _page = page;
    fetch();
  }

  void setSortOptions(SortOptions sortOptions) {
    _sortOptions = sortOptions;
    fetch();
  }

  void fetch() async {
    _loading = true;
    notifyListeners();

    _replies = await RepliesRepository().fetchPostReplies(_postId);
    _loading = false;
    notifyListeners();
  }
}
