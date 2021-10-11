import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/repositories/comments_repository.dart';

class CommentsProvider with ChangeNotifier {
  bool _loading = true;
  int _page = 1;
  List<CommentCollectionItem> _comments = [];

  bool get loading => _loading;

  int get page => _page;

  List<CommentCollectionItem> get comments => _comments;

  void fetch(int page, SortOptions sortOptions) async {
    _loading = true;
    _comments = await (CommentsRepository()).fetchComments(page, sortOptions);
    _loading = false;
    notifyListeners();
  }
}
