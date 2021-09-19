import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String? title;

  const AppBarTitle({
    Key? key,
    String? this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'karab.in',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
