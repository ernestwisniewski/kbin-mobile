import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_leading.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';
import 'package:kbin_mobile/widgets/entry.dart';
import 'package:kbin_mobile/widgets/loading_full.dart';
import 'package:kbin_mobile/widgets/sort_options.dart';
import 'package:kbin_mobile/widgets/time_options.dart';
import 'package:kbin_mobile/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  late SettingsProvider settings;

  @override
  void initState() {
    super.initState();

    settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();

    final entry = Provider.of<EntriesProvider>(context, listen: false);
    entry.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                middle:
                    const FittedBox(child: const TopBar(route: EntriesRoute())),
                leading: buildAppBarLeading(context),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    timeOptions(context,
                        Provider.of<EntriesProvider>(context, listen: false)),
                    sortOptions(context,
                        Provider.of<EntriesProvider>(context, listen: false))
                  ],
                )),
            child: buildBody(context));
      },
      tabBar: buildBottomNavbar(context, 0),
    );
    // bottomNavigationBar: buildBottomNavbar(context, 0));
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
            return Scrollbar(
              showTrackOnHover: true,
              isAlwaysShown: false,
              child: ListView.builder(
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
