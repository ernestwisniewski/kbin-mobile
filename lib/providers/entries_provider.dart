import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/models/entry_item_model.dart';
import 'package:kbin_mobile/repositories/entries_repository.dart';

class EntriesProvider with ChangeNotifier {
  bool _loading = true;
  int _page = 1;
  List<EntryCollectionItem> _entries = [];

  bool get loading => _loading;

  int get page => _page;

  List<EntryCollectionItem> get entries => _entries;

  void fetch(int page, SortOptions sortOptions) async {
    _loading = true;
    _entries = await EntriesRepository().fetchEntries(page, sortOptions);
    _loading = false;

    notifyListeners();
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
