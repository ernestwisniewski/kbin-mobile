import 'package:auto_route/auto_route.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/providers/filters_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  final String? title;
  final String? magazine;
  final double? fontSize;
  final PageRouteInfo? route;
  final Type? provider;

  const TopBar(
      {Key? key,
      this.title,
      this.magazine,
      this.fontSize,
      this.route,
      this.provider})
      : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late SettingsProvider settings;

  @override
  void initState() {
    super.initState();

    settings = Provider.of<SettingsProvider>(context, listen: false);
    settings.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FiltersProvider>(builder: (context, filters, child) {
      if (widget.route != null) {
        return GestureDetector(
          onTap: () => showCupertinoModalPopup(
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
                      filters.screenView ?? widget.magazine ?? 'Losowy magazyn',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (widget.magazine != null) {
                      filters.setScreenView(widget.magazine!);
                    }

                    context.router.popUntilRoot();
                    context.router.push(SceneRoute(route: widget.route!));
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text('Wszystkie'),
                  onPressed: () {
                    filters.clearScreenView();

                    context.router.popUntilRoot();
                    context.router.push(SceneRoute(route: widget.route!));
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text('Subskrybowane'),
                  onPressed: () {
                    filters.clearScreenView();

                    context.router.popUntilRoot();
                    context.router.push(SceneRoute(route: widget.route!));
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text('Moderowane'),
                  onPressed: () {
                    filters.clearScreenView();

                    context.router.popUntilRoot();
                    context.router.push(SceneRoute(route: widget.route!));
                  },
                ),
              ],
            ),
          ),
          child: Text(
            filters.screenView ?? widget.magazine ?? settings.instance ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: widget.fontSize),
          ),
        );
      }

      return Text(
        widget.title ?? settings.instance ?? '',
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: widget.fontSize),
      );
    });
  }
}
