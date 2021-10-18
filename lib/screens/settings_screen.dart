import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ustawienia')),
      body: buildSettingsList(context),
    );
  }

  Widget buildSettingsList(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (!snapshot.hasData) {
            return buildLoadingFull();
          }

          return SettingsList(
            sections: [
              SettingsSection(
                title: 'Ogólne',
                tiles: [
                  SettingsTile(
                    title: 'Język',
                    subtitle: snapshot.data!.getString('lang') == 'pl'
                        ? 'Polski'
                        : 'English',
                    leading: const Icon(Icons.language),
                    onPressed: (context) {
                      context.router.push(const LanguageRoute());
                    },
                  ),
                  const SettingsTile(
                    title: 'Instancja',
                    subtitle: 'karab.in',
                    leading: Icon(Icons.cloud_queue),
                  ),
                  SettingsTile(
                    title: 'Wygląd',
                    subtitle: ThemeProvider.controllerOf(context).theme.id ==
                            'dark_theme'
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
                  SettingsTile(title: 'Email', leading: Icon(Icons.email)),
                  SettingsTile(title: 'Hasło', leading: Icon(Icons.lock)),
                  SettingsTile(
                      title: 'Wyloguj', leading: Icon(Icons.exit_to_app)),
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
                      title: 'Github',
                      leading: Icon(Icons.collections_bookmark)),
                ],
              ),
              CustomSection(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 8),
                      child: Container(),
                    ),
                    FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder:
                            (context, AsyncSnapshot<PackageInfo> snapshot) {
                          if (snapshot.hasData) {
                            return buildVersion(snapshot.data!);
                          }

                          return const Text(
                            'Wersja 0.01',
                            style: TextStyle(color: Color(0xFF777777)),
                          );
                        }),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget buildVersion(PackageInfo info) {
    return Text(
      'Wersja ${info.version}, #${info.buildNumber}',
      style: TextStyle(color: Color(0xFF777777)),
    );
  }
}
