import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_comment_collection_model.dart';
import 'package:kbin_mobile/repositories/comments_repository.dart';

class CommentsProvider with ChangeNotifier {
  bool _loading = true;
  int _page = 1;
  List<CommentCollectionItem> _comments = [];
  SortOptions _sortOptions = SortOptions.hot;
  List<EntryCommentsItem> _entryComments = [];

  bool get loading => _loading;
  int get page => _page;
  List<CommentCollectionItem> get comments => _comments;
  List<EntryCommentsItem> get entryComments => _entryComments;
  SortOptions get sortOptions => _sortOptions;

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
    _comments = await CommentsRepository().fetchComments(_page, _sortOptions);
    _loading = false;

    notifyListeners();
  }
}
