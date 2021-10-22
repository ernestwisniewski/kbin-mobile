import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

import 'colors.dart';

AppTheme getLightAppTheme() {
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

AppTheme getDarkAppTheme() {
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