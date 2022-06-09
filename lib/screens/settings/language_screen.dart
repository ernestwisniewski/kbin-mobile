import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late SettingsProvider settings;

  @override
  void initState() {
    super.initState();

    settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: const FittedBox(child: NavBarMiddle(title: 'Język')),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              child: const Icon(CupertinoIcons.back, size: 20),
              onPressed: () {
                context.router.pop();
              },
            )),
        child: SafeArea(
          child: Material(
              type: MaterialType.transparency,
              child: Consumer<SettingsProvider>(
                  builder: (context, settings, child) {
                return SettingsList(sections: [
                  SettingsSection(tiles: [
                    SettingsTile(
                      title: const Text("English"),
                      trailing: trailingWidget('en'),
                      onPressed: (BuildContext context) {
                        changeLanguage('en');
                      },
                    ),
                    SettingsTile(
                        title: const Text("Polski"),
                        trailing: trailingWidget('pl'),
                        onPressed: (BuildContext context) {
                          changeLanguage('pl');
                        }),
                  ])
                ]);
              })),
        ));
  }

  Widget trailingWidget(String newLang) {
    return (newLang == settings.lang)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeLanguage(String newLang) async {
    settings.setLang(newLang);
  }
}
