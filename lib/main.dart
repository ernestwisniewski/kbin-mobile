import 'package:flutter/material.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate:_appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'karab.in',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ));
  }
}
