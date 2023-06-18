import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget timeOptions(BuildContext context, dynamic provider) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    alignment: Alignment.centerRight,
    child: const Icon(CupertinoIcons.stopwatch, size: 20),
    onPressed: () => showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        title: Text(AppLocalizations.of(context)!.content_time_sort),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context)!.content_time_all,
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
            child: Text(AppLocalizations.of(context)!.content_time_6h,
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
            child: Text(AppLocalizations.of(context)!.content_time_12h,
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
            child: Text(AppLocalizations.of(context)!.content_time_day,
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
            child: Text(AppLocalizations.of(context)!.content_time_week,
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
            child: Text(AppLocalizations.of(context)!.content_time_month,
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
            child: Text(AppLocalizations.of(context)!.content_time_year,
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
  );
}
