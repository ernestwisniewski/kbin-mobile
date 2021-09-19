import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/widgets/app_bar_title.dart';

class EntryScreen extends StatelessWidget {
  final String magazine;
  final int id;

  const EntryScreen(
      {Key? key,
      @PathParam('magazine') required this.magazine,
      @PathParam('id') required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarTitle(title: magazine),
        ),
        body: Container(
          color: Colors.transparent,
          child: Text('entry' + id.toString()),
        ));
  }
}
