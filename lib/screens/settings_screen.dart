import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          middle: FittedBox(
            child: NavBarMiddle(title: AppLocalizations.of(context)!.settings),
          ),
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
            title: Text(AppLocalizations.of(context)!.settings_general),
            tiles: [
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.settings_language),
                value: Material(
                  type: MaterialType.transparency,
                  child: Text(AppLocalizations.of(context)!.language_name),
                ),
                leading: const Icon(Icons.language),
                onPressed: (context) {
                  context.router.push(const LanguageRoute());
                },
              ),
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.settings_instances),
                value: Material(
                    type: MaterialType.transparency,
                    child: Text(settings.instance)),
                leading: const Icon(Icons.cloud_queue),
                onPressed: (context) {
                  context.router.push(const InstanceRoute());
                },
              ),
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.settings_theme),
                value: ThemeProvider.controllerOf(context).theme.id ==
                        'dark_theme'
                    ? Material(
                        type: MaterialType.transparency,
                        child: Text(
                            AppLocalizations.of(context)!.settings_theme_dark))
                    : Material(
                        type: MaterialType.transparency,
                        child: Text(AppLocalizations.of(context)!
                            .settings_theme_light)),
                leading: const Icon(Icons.lightbulb),
                onPressed: (context) {
                  ThemeProvider.controllerOf(context).nextTheme();
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settings_account),
            tiles: [
              SettingsTile(
                title:
                    Text(AppLocalizations.of(context)!.settings_account_login),
                leading: null,
              ),
              SettingsTile(
                title: Text(
                    AppLocalizations.of(context)!.settings_account_register),
                leading: null,
              ),
            ],
          ),
          SettingsSection(
            title: Text(
              AppLocalizations.of(context)!.settings_security,
            ),
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
                title: Text(
                  AppLocalizations.of(context)!.settings_security_fingerprint,
                ),
                // subtitle:
                //     'Pozwól odblokowywać aplikację za pomocą odcisku palca.',
                leading: const Icon(Icons.fingerprint),
                onToggle: (bool value) {},
                // switchValue: false,
                initialValue: null,
              ),
              SettingsTile.switchTile(
                title: Text(
                  AppLocalizations.of(context)!.settings_security_notifications,
                ),
                enabled: _notificationsEnabled,
                leading: const Icon(Icons.notifications_active),
                // switchValue: true,
                onToggle: (value) {},
                initialValue: null,
              ),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settings_other),
            tiles: [
              SettingsTile(
                  title: const Text('Github'),
                  leading: const Icon(Icons.collections_bookmark)),
            ],
          ),
        ],
      );
    });
  }
}
