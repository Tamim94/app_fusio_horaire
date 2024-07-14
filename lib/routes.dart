import 'package:flutter/material.dart';
import 'package:app_fusio_horaire/mobile/screen_mobile.dart';
import 'package:app_fusio_horaire/themeswapper.dart';
import 'package:app_fusio_horaire/web/screen_web.dart';

// Route settings for taking the user to a page according to the screen size
class Routes {
  static const String home = '/';
  static const String swap_page = '/swap_page';
  static const String accueil = '/accueil';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case swap_page:
        final notifier = settings.arguments as ValueNotifier<ThemeMode>;
        return _responsiveRoute(ThemeSwapper(notifier), ThemeSwapper(notifier));
      case home:
        return _responsiveRoute(ScreenWeb(), ScreenMobile());
      case accueil:
        return _responsiveRoute(ScreenWeb(), ScreenMobile());
      default:
        return _responsiveRoute(ScreenMobile(), ScreenWeb(), settings);
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
