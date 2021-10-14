import 'package:flutter/material.dart';
import 'package:kbin_mobile/repositories/api_provider.dart';

class AppBarTitle extends StatelessWidget {
  final String? title;
  final double? fontSize;

  const AppBarTitle({
    Key? key,
    this.title,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? ApiProvider().getDomain(),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
    );
  }
}
