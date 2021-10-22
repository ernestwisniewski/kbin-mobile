import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();

    final settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const FittedBox(child: TopBar(title: 'Ustawienia')),
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
        ),
      ),
      child: SafeArea(child: buildSettingsList(context)),
    );
  }

  Widget buildSettingsList(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, settings, child) {
      return SettingsList(
        sections: [
          SettingsSection(
            title: 'Ogólne',
            tiles: [
              SettingsTile(
                title: 'Język',
                subtitle: settings.lang == 'pl' ? 'Polski' : 'English',
                leading: const Icon(Icons.language),
                onPressed: (context) {
                  context.router.push(const LanguageRoute());
                },
              ),
              SettingsTile(
                title: 'Instancja',
                subtitle: settings.instance,
                leading: const Icon(Icons.cloud_queue),
                onPressed: (context) {
                  context.router.push(const InstanceRoute());
                },
              ),
              SettingsTile(
                title: 'Wygląd',
                subtitle:
                    ThemeProvider.controllerOf(context).theme.id == 'dark_theme'
                        ? 'Ciemny'
                        : 'Jasny',
                leading: const Icon(Icons.lightbulb),
                onPressed: (context) {
                  ThemeProvider.controllerOf(context).nextTheme();
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Konto',
            tiles: const [
              SettingsTile(title: 'Zaloguj się', leading: null),
              SettingsTile(title: 'Zarejestruj się', leading: null),
            ],
          ),
          SettingsSection(
            title: 'Bezpieczeństwo',
            tiles: [
              SettingsTile.switchTile(
                title: 'Pozwól aplikacji działać w tle',
                leading: const Icon(Icons.phonelink_lock),
                switchValue: lockInBackground,
                onToggle: (bool value) {
                  setState(() {
                    lockInBackground = value;
                    notificationsEnabled = value;
                  });
                },
              ),
              SettingsTile.switchTile(
                title: 'Użyj odcisku palca',
                subtitle:
                    'Pozwól odblokowywać aplikację za pomocą odcisku palca.',
                leading: const Icon(Icons.fingerprint),
                onToggle: (bool value) {},
                switchValue: false,
              ),
              SettingsTile.switchTile(
                title: 'Włącz powiadomienia',
                enabled: notificationsEnabled,
                leading: const Icon(Icons.notifications_active),
                switchValue: true,
                onToggle: (value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Inne',
            tiles: const [
              SettingsTile(
                  title: 'Regulamin', leading: Icon(Icons.description)),
              SettingsTile(
                  title: 'Github', leading: Icon(Icons.collections_bookmark)),
            ],
          ),
          CustomSection(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(),
                ),
                Text(
                  settings.version ?? '',
                  style: const TextStyle(color: Color(0xFF777777)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
