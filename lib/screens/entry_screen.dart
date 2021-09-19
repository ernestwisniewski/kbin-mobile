import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/models/entry_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';
import 'package:kbin_mobile/widgets/entry_card.dart';

class EntryScreen extends StatelessWidget {
  final String magazine;
  final int id;

  const EntryScreen({Key? key,
    @PathParam('magazine') required this.magazine,
    @PathParam('id') required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EntriesProvider provider = EntriesProvider();

    return Scaffold(
        appBar: AppBar(
          title: AppBarTitle(title: magazine, fontSize: 16),
        ),
        body: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: FutureBuilder(
              future: provider.fetchEntry(id),
              builder: (BuildContext context, AsyncSnapshot<Entry> snapshot) {
                if (snapshot.hasData) {
                  Entry entry = snapshot.data!;
                  return Container(
                      margin: const EdgeInsets.only(left: 0, right: 0),
                      child: Column(
                        children: [
                          EntryCard(entry: entry),
                          const Padding(
                            padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 20, bottom: 20),
                            child: Align(alignment: Alignment.topLeft,
                                child: Text('Komentrze:',
                                    style: TextStyle(fontSize: 22))),
                          ),
                        ],
                      ));
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
