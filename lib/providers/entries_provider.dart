import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/filters/stort_options_filters.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/models/entry_item_model.dart';
import 'package:kbin_mobile/providers/filters_provider.dart';
import 'package:kbin_mobile/repositories/entries_repository.dart';

class EntriesProvider with ChangeNotifier {
  final FiltersProvider? _filtersProvider;
  bool _loading = false;
  int _page = 1;
  List<EntryCollectionItem> _entries = [];
  SortOptions _sortOptions = SortOptions.hot;
  TimeOptions _timeOptions = TimeOptions.fromall;

  EntriesProvider(this._filtersProvider);

  bool get loading => _loading;

  int get page => _page;

  String? get screenView => _filtersProvider != null ? _filtersProvider!.screenView : null;

  List<EntryCollectionItem> get entries => _entries;

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

  Future<List<EntryCollectionItem>> fetch() async {
    _loading = true;
    _entries = await EntriesRepository()
        .fetchEntries(_page, _sortOptions, _timeOptions, screenView);
    _loading = false;

    notifyListeners();

    return _entries;
  }
}

class EntryProvider with ChangeNotifier {
  bool _loading = true;
  late EntryItem _entry;

  bool get loading => _loading;

  EntryItem get entry => _entry;

  void fetch(int id) async {
    _loading = true;
    _entry = await EntriesRepository().fetchEntry(id);
    _loading = false;
    notifyListeners();
  }
}
