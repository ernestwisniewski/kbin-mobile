import 'package:flutter/material.dart';
import 'package:kbin_mobile/model/entry_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';

class FrontScreen extends StatelessWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EntriesProvider provider = EntriesProvider();

    return Scaffold(
        appBar: AppBar(
          title: Text('karab.in'),
        ),
        body: Container(
          child: SafeArea(
            child: FutureBuilder(
              future: provider.fetchEntries(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Card(
                              color: Colors.black.withOpacity(0.5),
                              child: ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Entry entry = snapshot.data![index];
                                    return ListTile(title: Text(entry.title));
                                  })),
                        ),
                      )
                    ],
                  );
                }

                return Center(
                  child: Column(
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
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
