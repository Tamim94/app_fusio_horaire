import 'package:flutter/material.dart';
import 'package:app_fusio_horaire/mobile/screen_mobile.dart';
import 'package:app_fusio_horaire/themeswapper.dart';
import 'package:app_fusio_horaire/web/screen_web.dart';

class Routes {
  static const String swap_page = '/swap_page';
  static const String accueil = '/accueil';

  static Route<dynamic> generateRoute(
      RouteSettings settings, ValueNotifier<ThemeMode> themeNotifier) {
    switch (settings.name) {
      case swap_page:
        return _responsiveRoute(
            ThemeSwapper(themeNotifier), ThemeSwapper(themeNotifier));
      case accueil:
        final args = settings.arguments as Map<String, dynamic>?;
        final selectedTimeZone =
            args?['selectedTimeZone'] as ValueNotifier<String>? ??
                ValueNotifier<String>("UTC+00:00");
        return _responsiveRoute(ScreenWeb(selectedTimeZone: selectedTimeZone),
            ScreenMobile(selectedTimeZone: selectedTimeZone));
      default:
        return _responsiveRoute(
            ScreenMobile(selectedTimeZone: ValueNotifier<String>("UTC+00:00")),
            ScreenWeb(selectedTimeZone: ValueNotifier<String>("UTC+00:00")),
            settings);
    }
  }

  static MaterialPageRoute _responsiveRoute(
      Widget webWidget, Widget mobileWidget,
      [RouteSettings? settings]) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth > 800 ? webWidget : mobileWidget;
      }),
    );
  }
}
