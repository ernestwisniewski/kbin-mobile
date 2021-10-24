import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/theme.dart';
import 'package:kbin_mobile/providers/comments_provider.dart';
import 'package:kbin_mobile/providers/entries_provider.dart';
import 'package:kbin_mobile/providers/entry_comments_provider.dart';
import 'package:kbin_mobile/providers/filters_provider.dart';
import 'package:kbin_mobile/providers/posts_provider.dart';
import 'package:kbin_mobile/providers/replies_provider.dart';
import 'package:kbin_mobile/providers/search_provider.dart';
import 'package:kbin_mobile/providers/settings_provider.dart';
import 'package:kbin_mobile/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  HttpOverrides.global = MyHttpOverrides(); // @todo enviroments
  timeago.setLocaleMessages('pl', timeago.PlMessages());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FiltersProvider()),
    ChangeNotifierProxyProvider<FiltersProvider, EntriesProvider>(
        create: (context) => EntriesProvider(null),
        update: (context, filters, previousMessages) =>
            EntriesProvider(filters)),
    ChangeNotifierProvider(create: (context) => EntryProvider()),
    ChangeNotifierProvider(create: (context) => EntryCommentsProvider()),
    ChangeNotifierProxyProvider<FiltersProvider, CommentsProvider>(
        create: (context) => CommentsProvider(null),
        update: (context, filters, previousMessages) =>
            CommentsProvider(filters)),
    ChangeNotifierProxyProvider<FiltersProvider, PostsProvider>(
        create: (context) => PostsProvider(null),
        update: (context, filters, previousMessages) =>
            PostsProvider(filters)),
    ChangeNotifierProvider(create: (context) => PostProvider()),
    ChangeNotifierProvider(create: (context) => RepliesProvider()),
    ChangeNotifierProvider(create: (context) => SearchProvider()),
    ChangeNotifierProvider(create: (context) => SettingsProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  late SettingsProvider _settings;

  @override
  void initState() {
    super.initState();

    _settings = Provider.of<SettingsProvider>(context, listen: false);
    _settings.fetch();

    if(_settings.instance == null) {
      _settings.setInstance('karab.in');
    }

    if(_settings.lang == null) {
      _settings.setLang('pl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        saveThemesOnChange: true,
        onInitCallback: (controller, previouslySavedThemeFuture) async {
          String? savedTheme = await previouslySavedThemeFuture;
          if (savedTheme != null) {
            controller.setTheme(savedTheme);
          }
        },
        themes: [getLightAppTheme(), getDarkAppTheme()],
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp.router(
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
                title: _settings.instance ?? '',
                themeMode: ThemeMode.light,
                theme: ThemeProvider.themeOf(themeContext).data),
          ),
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
