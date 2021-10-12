import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/repositories/replies_repository.dart';

class RepliesProvider with ChangeNotifier {
  bool _loading = true;
  int _page = 1;
  List<ReplyCollectionItem> _replies = [];

  bool get loading => _loading;

  int get page => _page;

  List<ReplyCollectionItem> get replies => _replies;

  void fetch(int postId, int page, SortOptions sortOptions) async {
    _loading = true;
    _replies = await RepliesRepository().fetchPostReplies(postId);
    _loading = false;

    notifyListeners();
  }
}
