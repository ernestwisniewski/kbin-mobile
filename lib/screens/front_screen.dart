import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/models/entry_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/widgets/entry_card.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EntriesProvider provider = EntriesProvider();

    return Scaffold(
        appBar: AppBar(
          title: const Text('karab.in'),
        ),
        body: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: FutureBuilder(
              future: provider.fetchEntries(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
                if (snapshot.hasData) {
                  return EntryCard(snapshot: snapshot);
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
