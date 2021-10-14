import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:provider/provider.dart';

Widget timeOptions(BuildContext context, dynamic provider) {
  return IconButton(
    icon: const Icon(Icons.watch_later_outlined),
    tooltip: 'Zakres czasowy',
    onPressed: () => showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Anuluj'),
        ),
        title: const Text('Zakres czasowy'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Wszystko'),
            onPressed: () {
              provider.setTimeOptions(TimeOptions.fromall);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('6 godzin'),
            onPressed: () {
              provider.setTimeOptions(TimeOptions.from6h);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('12 godzin'),
            onPressed: () {
              provider.setTimeOptions(TimeOptions.from12h);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('dzień'),
            onPressed: () {
              provider.setTimeOptions(TimeOptions.from1d);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('tydzień'),
            onPressed: () {
              provider.setTimeOptions(TimeOptions.from1w);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('miesiąc'),
            onPressed: () {
              provider.setTimeOptions(TimeOptions.from1m);
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('rok'),
            onPressed: () {
              provider.setTimeOptions(TimeOptions.from1y);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
