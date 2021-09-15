import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/screens/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'karab.in',
        theme: ThemeData(
          primarySwatch: KbinColors().fromHex('556880'),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MenuScreen(),
        });
  }
}
