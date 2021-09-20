import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbin_mobile/models/entry_model.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;

  const EntryCard({Key? key, required this.entry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 30, bottom: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(entry.title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
