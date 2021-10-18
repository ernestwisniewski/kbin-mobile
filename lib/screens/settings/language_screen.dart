import 'package:flutter/material.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String languageIndex = 'pl';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Język')),
      body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
            if (!snapshot.hasData) {
              return buildLoadingFull();
            }

            SharedPreferences lang = snapshot.data!;
            return SettingsList(backgroundColor: Colors.transparent, sections: [
              SettingsSection(tiles: buildTiles(lang)),
            ]);
          }),
    );
  }

  Widget trailingWidget(String newLang, String current) {
    return (newLang == current)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeLanguage(String newLang, SharedPreferences prefs) async {
    await prefs.setString('lang', newLang);
    setState(() {
      languageIndex = newLang;
    });
  }

  List<SettingsTile> buildTiles(SharedPreferences prefs) {
    String index = prefs.getString('lang') ?? 'pl';
    return [
      SettingsTile(
        title: "English",
        trailing: trailingWidget('en', index),
        onPressed: (BuildContext context) {
          changeLanguage('en', prefs);
        },
      ),
      SettingsTile(
          title: "Polski",
          trailing: trailingWidget('pl', index),
          onPressed: (BuildContext context) {
            changeLanguage('pl', prefs);
          }),
    ];
  }
}
