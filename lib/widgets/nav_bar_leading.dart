import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNavBarLeading(BuildContext context) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    alignment: Alignment.centerLeft,
    child:
        const Icon(Icons.menu, size: 20),
    onPressed: () {
      context.router.popUntilRoot();
    },
  );
}
