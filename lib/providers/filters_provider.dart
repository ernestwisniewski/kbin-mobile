import 'package:flutter/foundation.dart';

class FiltersProvider with ChangeNotifier {
  String? _screenView;

  String? get screenView => _screenView;

  void setScreenView(String screenView) async {
    _screenView = screenView;

    notifyListeners();
  }

  void clearScreenView() async {
    _screenView = null;

    notifyListeners();
  }
}
