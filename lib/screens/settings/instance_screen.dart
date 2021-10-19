import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class InstanceScreen extends StatefulWidget {
  @override
  _InstanceScreenState createState() => _InstanceScreenState();
}

class _InstanceScreenState extends State<InstanceScreen> {
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
            middle: const TopBar(title: 'Instancja'),
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
                  title: "karab.in",
                  trailing: trailingWidget('karab.in'),
                  onPressed: (BuildContext context) {
                    changeInstance('karab.in');
                  },
                ),
                SettingsTile(
                    title: "dev.karab.in",
                    trailing: trailingWidget('dev.karab.in'),
                    onPressed: (BuildContext context) {
                      changeInstance('dev.karab.in');
                    }),
                SettingsTile(
                    title: "kbin.pub",
                    trailing: trailingWidget('kbin.pub'),
                    onPressed: (BuildContext context) {
                      changeInstance('kbin.pub');
                    }),
              ]);
            },
          ),
        )));
  }

  Widget trailingWidget(String newInstance) {
    return (newInstance == settings.instance)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeInstance(String newInstance) async {
    settings.setInstance(newInstance);
  }
}
