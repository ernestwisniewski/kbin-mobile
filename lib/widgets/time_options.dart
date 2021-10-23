import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:kbin_mobile/helpers/colors.dart';

Widget timeOptions(BuildContext context, dynamic provider) {
  return Material(
    type: MaterialType.transparency,
    child: IconButton(
      color: KbinColors().getAppBarTextColor(),
      icon: const Icon(CupertinoIcons.stopwatch, size: 20),
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
          title: const Text('Z jakiego zakresu czasowego treści wyświetlić?'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: Text('Wszystko',
                  style: TextStyle(
                      fontWeight: provider.timeOptions == TimeOptions.fromall
                          ? FontWeight.bold
                          : FontWeight.normal)),
              onPressed: () {
                provider.setTimeOptions(TimeOptions.fromall);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('6 godzin',
                  style: TextStyle(
                      fontWeight: provider.timeOptions == TimeOptions.from6h
                          ? FontWeight.bold
                          : FontWeight.normal)),
              onPressed: () {
                provider.setTimeOptions(TimeOptions.from6h);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('12 godzin',
                  style: TextStyle(
                      fontWeight: provider.timeOptions == TimeOptions.from12h
                          ? FontWeight.bold
                          : FontWeight.normal)),
              onPressed: () {
                provider.setTimeOptions(TimeOptions.from12h);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('dzień',
                  style: TextStyle(
                      fontWeight: provider.timeOptions == TimeOptions.from1d
                          ? FontWeight.bold
                          : FontWeight.normal)),
              onPressed: () {
                provider.setTimeOptions(TimeOptions.from1d);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('tydzień',
                  style: TextStyle(
                      fontWeight: provider.timeOptions == TimeOptions.from1w
                          ? FontWeight.bold
                          : FontWeight.normal)),
              onPressed: () {
                provider.setTimeOptions(TimeOptions.from1w);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('miesiąc',
                  style: TextStyle(
                      fontWeight: provider.timeOptions == TimeOptions.from1m
                          ? FontWeight.bold
                          : FontWeight.normal)),
              onPressed: () {
                provider.setTimeOptions(TimeOptions.from1m);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('rok',
                  style: TextStyle(
                      fontWeight: provider.timeOptions == TimeOptions.from1y
                          ? FontWeight.bold
                          : FontWeight.normal)),
              onPressed: () {
                provider.setTimeOptions(TimeOptions.from1y);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
