import 'package:app_fusio_horaire/routes.dart';
import 'package:flutter/material.dart';
import 'package:app_fusio_horaire/themeswapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.system);

  runApp(
    ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        print('Theme mode: $mode');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          onGenerateRoute: (settings) =>
              Routes.generateRoute(settings, _notifier),
          home: ThemeSwapper(_notifier),
        );
      },
    ),
  );
}
