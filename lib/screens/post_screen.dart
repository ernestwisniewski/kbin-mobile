import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final int id;

  const PostScreen({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('karab.in'),
        ),
        body: Container(
          color: Colors.transparent,
          child: const Text('post'),
        ));
  }
}
