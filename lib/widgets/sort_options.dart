import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/filters/stort_options_filters.dart';

Widget sortOptions(BuildContext context, dynamic provider) {
  return IconButton(
    icon: const Icon(Icons.more_vert),
    tooltip: 'Sortuj',
    onPressed: () => showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Anuluj'),
        ),
        title: const Text('Sortuj'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Ważne'),
            onPressed: () {
              provider.setSortOptions(SortOptions.top);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Wschodzące'),
            onPressed: () {
              provider.setSortOptions(SortOptions.hot);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Aktywne'),
            onPressed: () {
              provider.setSortOptions(SortOptions.active);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Najnowsze'),
            onPressed: () {
              provider.setSortOptions(SortOptions.newest);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Komentowane'),
            onPressed: () {
              provider.setSortOptions(SortOptions.commented);
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  );
}
