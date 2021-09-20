import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kbin_mobile/helpers/colors.dart';
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
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'karab.in',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: KbinColors().fromHex('556880'),
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme:
              AppBarTheme(backgroundColor: KbinColors().fromHex('556880')),
          // Shared
          // fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: const TextTheme(subtitle1: TextStyle(fontWeight: FontWeight.w400)),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ));
  }
}
