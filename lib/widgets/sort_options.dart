import 'package:flutter/cupertino.dart';
import 'package:kbin_mobile/filters/stort_options_filters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        title: Text(AppLocalizations.of(context)!.content_filter),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context)!.content_top,
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
            child: Text(AppLocalizations.of(context)!.content_hot,
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
            child: Text(AppLocalizations.of(context)!.content_active,
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
            child: Text(AppLocalizations.of(context)!.content_new,
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
            child: Text(AppLocalizations.of(context)!.content_commented,
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
