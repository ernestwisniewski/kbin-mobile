import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _lockInBackground = true;
  bool _notificationsEnabled = true;

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
          middle: const FittedBox(child: NavBarMiddle(title: 'Ustawienia')),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            child: const Icon(CupertinoIcons.back, size: 20),
            onPressed: () {
              context.router.pop();
            },
          )),
      child: SafeArea(child: buildSettingsList(context)),
    );
  }

  Widget buildSettingsList(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, settings, child) {
      return SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Ogólne'),
            tiles: [
              SettingsTile(
                title: const Text('Język'),
                value: settings.lang == 'pl'
                    ? const Material(
                        type: MaterialType.transparency, child: Text('polski'))
                    : const Material(
                        type: MaterialType.transparency,
                        child: Text('english')),
                leading: const Icon(Icons.language),
                onPressed: (context) {
                  context.router.push(const LanguageRoute());
                },
              ),
              SettingsTile(
                title: const Text('Instancja'),
                value: Material(
                    type: MaterialType.transparency,
                    child: Text(settings.instance)),
                leading: const Icon(Icons.cloud_queue),
                onPressed: (context) {
                  context.router.push(const InstanceRoute());
                },
              ),
              SettingsTile(
                title: const Text('Wygląd'),
                value:
                    ThemeProvider.controllerOf(context).theme.id == 'dark_theme'
                        ? const Material(
                            type: MaterialType.transparency,
                            child: Text('ciemny'))
                        : const Material(
                            type: MaterialType.transparency,
                            child: Text('jasny')),
                leading: const Icon(Icons.lightbulb),
                onPressed: (context) {
                  ThemeProvider.controllerOf(context).nextTheme();
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Konto'),
            tiles: [
              SettingsTile(title: const Text('Zaloguj się'), leading: null),
              SettingsTile(title: const Text('Zarejestruj się'), leading: null),
            ],
          ),
          SettingsSection(
            title: Text('Bezpieczeństwo'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Pozwól aplikacji działać w tle'),
                leading: const Icon(Icons.phonelink_lock),
                onToggle: (bool value) {
                  setState(() {
                    _lockInBackground = value;
                    _notificationsEnabled = value;
                  });
                },
                initialValue: null,
              ),
              SettingsTile.switchTile(
                title: const Text('Użyj odcisku palca'),
                // subtitle:
                //     'Pozwól odblokowywać aplikację za pomocą odcisku palca.',
                leading: const Icon(Icons.fingerprint),
                onToggle: (bool value) {},
                // switchValue: false,
                initialValue: null,
              ),
              SettingsTile.switchTile(
                title: const Text('Włącz powiadomienia'),
                enabled: _notificationsEnabled,
                leading: const Icon(Icons.notifications_active),
                // switchValue: true,
                onToggle: (value) {},
                initialValue: null,
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Inne'),
            tiles: [
              SettingsTile(
                  title: const Text('Regulamin'),
                  leading: const Icon(Icons.description)),
              SettingsTile(
                  title: Text('Github'),
                  leading: const Icon(Icons.collections_bookmark)),
            ],
          ),
          // CustomSection(
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 25),
          //         child: Container(),
          //       ),
          //       Text(
          //         settings.version ?? '',
          //         style: const TextStyle(color: Color(0xFF777777)),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 25),
          //         child: Container(),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );
    });
  }
}
