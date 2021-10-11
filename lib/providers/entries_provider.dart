import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/repositories/entries_repository.dart';

class EntriesProvider with ChangeNotifier {
  bool _loading = false;
  int _page = 1;
  List<EntryCollectionItem> _entries = [];

  int get page => _page;

  List<EntryCollectionItem> get entries => _entries;

  void fetch(int page, SortOptions sortOptions) async {
    _loading = true;
    _entries = await (EntriesRepository()).fetchEntries(page, sortOptions);
    _loading = false;

    notifyListeners();
  }
}
