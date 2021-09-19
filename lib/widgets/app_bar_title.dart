import 'package:flutter/material.dart';

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
      title ?? 'karab.in',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
    );
  }
}
