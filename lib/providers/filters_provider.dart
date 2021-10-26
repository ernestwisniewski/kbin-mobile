import 'package:flutter/foundation.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/repositories/magazines_repository.dart';

class FiltersProvider with ChangeNotifier {
  String? _screenView;

  String? get screenView => _screenView;

  get http => null;

  void setScreenView(String screenView) async {
    _screenView = screenView;

    notifyListeners();
  }

  void clearScreenView() async {
    _screenView = null;

    notifyListeners();
  }
}
