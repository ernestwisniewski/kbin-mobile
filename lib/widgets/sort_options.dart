import 'package:flutter/cupertino.dart';
import 'package:kbin_mobile/filters/stort_options_filters.dart';

Widget sortOptions(BuildContext context, dynamic provider) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    alignment: Alignment.centerRight,
    child: const Icon(CupertinoIcons.ellipsis_vertical, size: 20),
    onPressed: () => showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Anuluj'),
        ),
        title: const Text('Jakie treści wyświetlić'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('Ważne',
                style: TextStyle(
                    fontWeight: provider.sortOptions == SortOptions.top
                        ? FontWeight.bold
                        : FontWeight.normal)),
            onPressed: () {
              provider.setSortOptions(SortOptions.top);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Wschodzące',
                style: TextStyle(
                    fontWeight: provider.sortOptions == SortOptions.hot
                        ? FontWeight.bold
                        : FontWeight.normal)),
            onPressed: () {
              provider.setSortOptions(SortOptions.hot);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Aktywne',
                style: TextStyle(
                    fontWeight: provider.sortOptions == SortOptions.active
                        ? FontWeight.bold
                        : FontWeight.normal)),
            onPressed: () {
              provider.setSortOptions(SortOptions.active);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Najnowsze',
                style: TextStyle(
                    fontWeight: provider.sortOptions == SortOptions.newest
                        ? FontWeight.bold
                        : FontWeight.normal)),
            onPressed: () {
              provider.setSortOptions(SortOptions.newest);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Komentowane',
                style: TextStyle(
                    fontWeight: provider.sortOptions == SortOptions.commented
                        ? FontWeight.bold
                        : FontWeight.normal)),
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
