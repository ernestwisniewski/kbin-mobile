import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  HttpOverrides.global = MyHttpOverrides(); // @todo enviroments
  timeago.setLocaleMessages('pl', timeago.PlMessages());

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
          fontFamily: GoogleFonts.openSans().fontFamily,
          textTheme: const TextTheme(subtitle1: TextStyle(fontWeight: FontWeight.w400)),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: GoogleFonts.openSans().fontFamily,
          textTheme: const TextTheme(subtitle1: TextStyle(fontWeight: FontWeight.w400)),
        ));
  }
}

// Local certs
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}