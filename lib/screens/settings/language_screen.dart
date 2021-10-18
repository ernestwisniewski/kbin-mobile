import 'package:flutter/material.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String lang = 'pl';
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Język')),
        body: SettingsSection(tiles: buildTiles()));
  }

  List<SettingsTile> buildTiles() {
    return [
      SettingsTile(
        title: "English",
        trailing: trailingWidget('en'),
        onPressed: (BuildContext context) {
          changeLanguage('en');
        },
      ),
      SettingsTile(
          title: "Polski",
          trailing: trailingWidget('pl'),
          onPressed: (BuildContext context) {
            changeLanguage('pl');
          }),
    ];
  }

  Widget trailingWidget(String newLang) {
    return (newLang == lang)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeLanguage(String newLang) async {
    await prefs!.setString('lang', newLang);
    setState(() {
      lang = newLang;
    });
  }

  void load() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    prefs = preferences;

    setState(() {
      lang = preferences.getString('lang') ?? 'pl';
    });
  }
}
