import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String _instance = 'karab.in';
  String _lang = 'en';
  String _version = '0.01';

  String get instance => _instance;

  String get lang => _lang;

  String get version => _version;

  void fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PackageInfo package = await PackageInfo.fromPlatform();

    _version = 'Version ${package.version}, #${package.buildNumber}';
    _lang = prefs.getString('lang') ?? 'en';
    _instance = prefs.getString('instance') ?? 'kbin.social';

    notifyListeners();
  }

  void setInstance(String instance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('instance', instance);

    _instance = instance;

    notifyListeners();
  }

  void setLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang);

    _lang = lang;

    notifyListeners();
  }
}
