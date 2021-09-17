import 'package:flutter/material.dart';

class MicroblogScreen extends StatelessWidget {
  const MicroblogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('karab.in'),
        ),
        body: Container(
          color: Colors.transparent,
          child: const Text('microblog'),
        ));
  }
}
