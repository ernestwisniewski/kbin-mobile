import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_comment_collection_model.dart';
import 'package:kbin_mobile/repositories/comments_repository.dart';

class EntryCommentsProvider with ChangeNotifier {
  bool _loading = true;
  int _page = 1;
  late int _entryId;
  List<EntryCommentsItem> _comments = [];
  SortOptions _sortOptions = SortOptions.hot;

  bool get loading => _loading;
  int get page => _page;
  List<EntryCommentsItem> get comments => _comments;
  SortOptions get sortOptions => _sortOptions;

  void setEntryId(int entryId){
    _entryId = entryId;
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
    _comments = await CommentsRepository().fetchEntryComments(_entryId);
    _loading = false;

    notifyListeners();
  }
}
