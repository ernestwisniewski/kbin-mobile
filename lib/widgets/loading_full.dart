import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';

Widget buildLoadingFull() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
            color: KbinColors().fromHex('556880')),
        const SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
