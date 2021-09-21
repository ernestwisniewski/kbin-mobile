import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/entry_model.dart';

class ActionButtons extends StatelessWidget {
  final Entry entry;

  const ActionButtons({
    Key? key,
    required this.entry
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                        padding:
                        const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextButton(
                          onPressed: null,
                          child: Column(children: [
                            const Icon(Icons.comment_sharp),
                            Text(entry.comments.toString())
                          ]),
                        )),
                  )),
              Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                        padding:
                        const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextButton(
                          onPressed: null,
                          child: Column(children: [
                            const Icon(Icons.arrow_upward),
                            Text(entry.uv.toString())
                          ]),
                        )),
                  )),
              Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                        padding:
                        const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextButton(
                          onPressed: null,
                          child: Column(children: [
                            const Icon(Icons.arrow_downward),
                            Text(entry.dv.toString())
                          ]),
                        )),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                        padding:
                        const EdgeInsets.only(top: 10, bottom: 10),
                        child: const TextButton(
                          onPressed: null,
                          child: Icon(Icons.share),
                        )),
                  )),
              Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                        padding:
                        const EdgeInsets.only(top: 10, bottom: 10),
                        child: const TextButton(
                          onPressed: null,
                          child: Icon(Icons.explore),
                        )),
                  )),
              Expanded(
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                        padding:
                        const EdgeInsets.only(top: 10, bottom: 10),
                        child: const TextButton(
                          onPressed: null,
                          child: Icon(Icons.report),
                        )),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
