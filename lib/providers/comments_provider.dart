import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/filters/stort_options_filters.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/repositories/comments_repository.dart';

import 'filters_provider.dart';

class CommentsProvider with ChangeNotifier {
  final FiltersProvider? _filtersProvider;
  bool _loading = false;
  int _page = 1;
  List<CommentCollectionItem> _comments = [];
  SortOptions _sortOptions = SortOptions.hot;
  TimeOptions _timeOptions = TimeOptions.fromall;

  CommentsProvider(this._filtersProvider);

  bool get loading => _loading;

  int get page => _page;

  String? get screenView =>
      _filtersProvider != null ? _filtersProvider!.screenView : null;

  List<CommentCollectionItem> get comments => _comments;

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

  void setScreenView(String? screenView) {
    if (screenView != null) {
      _filtersProvider!.setScreenView(screenView);
    } else {
      _filtersProvider!.clearScreenView();
    }

    fetch();
  }

  Future<List<CommentCollectionItem>> fetch() async {
    _loading = true;
    _comments = await CommentsRepository()
        .fetchComments(_page, _sortOptions, _timeOptions, screenView);
    _loading = false;

    notifyListeners();

    return _comments;
  }
}
