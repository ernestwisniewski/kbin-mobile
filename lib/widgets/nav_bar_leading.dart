import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';

Widget buildNavBarLeading(BuildContext context) {
  return Material(
    type: MaterialType.transparency,
    child: IconButton(
      color: KbinColors().getAppBarTextColor(),
      alignment: Alignment.centerLeft,
      icon: const Icon(Icons.menu, size: 20),
      tooltip: 'Menu',
      onPressed: () {
        context.router.popUntilRoot();
      },
    ),
  );
}
