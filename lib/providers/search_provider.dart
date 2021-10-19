import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/repositories/search_repository.dart';

class SearchProvider with ChangeNotifier {
  bool _loading = false;
  int _page = 1;
  List<dynamic> _results = [];
  late String _query;

  bool get loading => _loading;

  int get page => _page;

  List<dynamic> get results => _results;

  String get query => _query;

  void search(String query) async {
    _loading = true;
    notifyListeners();

    _query = query;
    _results = await SearchRepository().search(_query);
    _loading = false;
    notifyListeners();
  }
}
