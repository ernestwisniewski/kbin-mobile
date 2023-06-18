import 'package:auto_route/auto_route.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/providers/filters_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/repositories/magazines_repository.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavBarMiddle extends StatefulWidget {
  final String? title;
  final String? magazine;
  final double? fontSize;
  final PageRouteInfo? route;
  final Type? provider;

  const NavBarMiddle(
      {Key? key,
      this.title,
      this.magazine,
      this.fontSize,
      this.route,
      this.provider})
      : super(key: key);

  @override
  _NavBarMiddleState createState() => _NavBarMiddleState();
}

class _NavBarMiddleState extends State<NavBarMiddle> {
  late SettingsProvider _settings;
  late FiltersProvider _filters;
  late EntriesProvider _entries;

  @override
  void initState() {
    super.initState();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();

    _entries = Provider.of<EntriesProvider>(context, listen: false);

    _filters = Provider.of<FiltersProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FiltersProvider>(builder: (context, filters, child) {
      return CupertinoButton(
        onPressed: () => showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Anuluj'),
            ),
            title: const Text('Jakie magazyny wyświetlić?'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: Text(
                    filters.screenView ??
                        widget.magazine ??
                        AppLocalizations.of(context)!.magazines_random,
                    style: TextStyle(
                        fontWeight: filters.screenView != null
                            ? FontWeight.bold
                            : FontWeight.normal)),
                onPressed: () async {
                  if (widget.magazine != null) {
                    filters.setScreenView(widget.magazine!);
                  }

                  if (filters.screenView == null && widget.magazine == null) {
                    MagazineCollectionItem? magazine =
                        await MagazinesRepository().fetchRandom();
                    if (magazine != null) {
                      _filters.setScreenView(magazine.name);
                    }
                  }

                  context.router.navigate(
                      SceneRoute(route: widget.route ?? const EntriesRoute()));
                },
              ),
              CupertinoActionSheetAction(
                child: Text(AppLocalizations.of(context)!.all,
                    style: TextStyle(
                        fontWeight: filters.screenView == null
                            ? FontWeight.bold
                            : FontWeight.normal)),
                onPressed: () {
                  filters.clearScreenView();

                  context.router.navigate(
                      SceneRoute(route: widget.route ?? const EntriesRoute()));
                },
              ),
              CupertinoActionSheetAction(
                child: Text(AppLocalizations.of(context)!.subscribed),
                onPressed: () {},
              ),
              CupertinoActionSheetAction(
                child: Text(AppLocalizations.of(context)!.moderated),
                onPressed: () {},
              ),
            ],
          ),
        ),
        child: Text(
          widget.title ??
              filters.screenView ??
              widget.magazine ??
              _settings.instance,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize ?? 25,
              color: Colors.black87),
        ),
      );
    });
  }
}
