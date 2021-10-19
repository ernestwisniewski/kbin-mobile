import 'package:flutter/material.dart';
import 'package:kbin_mobile/repositories/api_provider.dart';

class TopBar extends StatefulWidget {
  final String? title;
  final double? fontSize;
  const TopBar({Key? key, this.title, this.fontSize}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}
class _TopBarState extends State<TopBar> {
  String domain = '';

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title ?? domain,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.fontSize),
    );
  }

  void load() async {
    String dom = await ApiProvider().getDomain();
    setState(() {
      domain = dom;
    });
  }
}
