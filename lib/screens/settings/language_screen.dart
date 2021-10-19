import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageScreen extends StatefulWidget {
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
            middle: const TopBar(title: 'Język'),
            leading: Material(
              type: MaterialType.transparency,
              child: IconButton(
                color: KbinColors().getAppBarTextColor(),
                alignment: Alignment.centerLeft,
                icon: const Icon(CupertinoIcons.back),
                tooltip: 'Wróć',
                onPressed: () {
                  context.router.pop();
                },
              ),
            )),
        child: SafeArea(
          child: Material(
              type: MaterialType.transparency,
              child: Consumer<SettingsProvider>(
                  builder: (context, settings, child) {
                return SettingsSection(tiles: [
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
