import 'package:flutter/material.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  final String? title;
  final double? fontSize;

  const TopBar({Key? key, this.title, this.fontSize}) : super(key: key);

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
    return Text(
      widget.title ?? settings.instance ?? '',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.fontSize),
    );
  }
}
