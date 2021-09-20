import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/models/entry_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/entry_card_list_item.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EntriesProvider provider = EntriesProvider();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.centerLeft,
            icon: const Icon(Icons.menu),
            tooltip: 'Przejdź do menu',
            onPressed: () {
              context.router.replace(const MenuRoute());
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Sortuj',
              onPressed: () {
                // handle the press
              },
            )
          ],
          title: const AppBarTitle(),
        ),
        body: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: FutureBuilder(
              future: provider.fetchEntries(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                  margin: const EdgeInsets.only(left: 0, right: 0),
                  child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    Entry entry = snapshot.data![index];
                    return EntryCardListItem(entry: entry, index: index);
                  }));
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          color: KbinColors().fromHex('556880')),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
