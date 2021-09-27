import 'package:flutter/material.dart';

Widget buildMetaItem(String label, IconData? icon, [bool highlighted = false]) {
  return Wrap(children: [
    icon != null ? Icon(icon, size: 15, color: Colors.grey) : Container(),
    Padding(
      padding: const EdgeInsets.only(left: 5, right: 15),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
            fontWeight: highlighted ? FontWeight.w600 : FontWeight.normal),
      ),
    )
  ]);
}
