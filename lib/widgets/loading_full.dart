import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';

Widget buildLoadingFull() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        CupertinoActivityIndicator(radius: 15),
        SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
