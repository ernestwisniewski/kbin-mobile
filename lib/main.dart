import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/providers/comments_provider.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/providers/posts_provider.dart';
import 'package:kbin_mobile/providers/replies_provider.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  HttpOverrides.global = MyHttpOverrides(); // @todo enviroments
  timeago.setLocaleMessages('pl', timeago.PlMessages());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EntriesProvider()),
    ChangeNotifierProvider(create: (context) => EntryProvider()),
    ChangeNotifierProvider(create: (context) => CommentsProvider()),
    ChangeNotifierProvider(create: (context) => PostsProvider()),
    ChangeNotifierProvider(create: (context) => PostProvider()),
    ChangeNotifierProvider(create: (context) => RepliesProvider()),
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        themes: [_getLightAppTheme(), _getDarkAppTheme()],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp.router(
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
                title: 'karab.in',
                themeMode: ThemeMode.light,
                theme: ThemeProvider.themeOf(themeContext).data),
          ),
        ));
  }

  AppTheme _getLightAppTheme() {
    return AppTheme(
        id: "light_theme",
        description: "Light Theme",
        data: ThemeData(
          primaryColor: KbinColors().fromHex('556880'),
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme:
              AppBarTheme(backgroundColor: KbinColors().fromHex('556880')),
          // Shared
          fontFamily: GoogleFonts.openSans().fontFamily,
          textTheme: const TextTheme(
              subtitle1: TextStyle(fontWeight: FontWeight.w400)),
        ));
  }

  AppTheme _getDarkAppTheme() {
    return AppTheme(
        id: "dark_theme",
        description: "Dark Theme",
        data: ThemeData(
          brightness: Brightness.dark,
          fontFamily: GoogleFonts.openSans().fontFamily,
          textTheme: const TextTheme(
              subtitle1: TextStyle(fontWeight: FontWeight.w400)),
        ));
  }
}

// Local certs
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
