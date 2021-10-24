import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/nav_bar_leading.dart';
import 'package:kbin_mobile/widgets/entry.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:kbin_mobile/widgets/nav_bar_middle.dart';
import 'package:provider/provider.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  late SettingsProvider _settings;
  late EntriesProvider _entries;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();

    _entries = Provider.of<EntriesProvider>(context, listen: false);
    _entries.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: const FittedBox(child: NavBarMiddle(route: EntriesRoute())),
            leading: buildNavBarLeading(context),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                timeOptions(context, _entries),
                sortOptions(context, _entries)
              ],
            )),
        child: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: buildEntryList(context),
    );
  }

  Widget buildEntryList(BuildContext context) {
    return Consumer<EntriesProvider>(
      builder: (context, state, child) {
        if (!state.loading) {
          if (state.entries.isNotEmpty) {
            return CupertinoScrollbar(
              controller: _controller,
              isAlwaysShown: false,
              child: ListView.builder(
                  controller: _controller,
                  itemCount: state.entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    EntryCollectionItem entry = state.entries[index];
                    return buildItem(context, entry, index);
                  }),
            );
          } else {
            return Material(
              type: MaterialType.transparency,
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  child: const Text('brak treści')),
            );
          }
        }

        return buildLoadingFull();
      },
    );
  }
}
