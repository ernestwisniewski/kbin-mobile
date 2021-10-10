import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

Widget buildAppBarLeading(BuildContext context) {
  return IconButton(
    alignment: Alignment.centerLeft,
    icon: const Icon(Icons.menu),
    tooltip: 'Menu',
    onPressed: () {
      context.router.popUntilRoot();
      context.router.replace(const MenuRoute());
    },
  );
}
