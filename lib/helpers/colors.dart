import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:theme_provider/theme_provider.dart';

class KbinColors {
  MaterialColor fromHex(String hex) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(136, 14, 79, .1),
      100: const Color.fromRGBO(136, 14, 79, .2),
      200: const Color.fromRGBO(136, 14, 79, .3),
      300: const Color.fromRGBO(136, 14, 79, .4),
      400: const Color.fromRGBO(136, 14, 79, .5),
      500: const Color.fromRGBO(136, 14, 79, 0.6),
      600: const Color.fromRGBO(136, 14, 79, .7),
      700: const Color.fromRGBO(136, 14, 79, .8),
      800: const Color.fromRGBO(136, 14, 79, .9),
      900: const Color.fromRGBO(136, 14, 79, 1),
    };

    return MaterialColor(HexColor(hex).value, color);
  }

  Color getEvenBackground(BuildContext context) {
    return ThemeProvider.controllerOf(context).theme.id == 'light_theme'
        ? Colors.black.withOpacity(0.03)
        : Colors.black.withOpacity(0.15);
  }

  Color getBottomNavSelectedColor(BuildContext context) {
    return ThemeProvider.controllerOf(context).theme.id == 'light_theme'
        ? Colors.black
        : Colors.white;
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
