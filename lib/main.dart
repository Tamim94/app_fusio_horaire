import 'package:app_fusio_horaire/routes.dart';
import 'package:flutter/material.dart';
import 'package:app_fusio_horaire/themeswapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MaterialApp(
          themeMode: mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          onGenerateRoute: (settings) => Routes.generateRoute(settings),
          initialRoute: '/', // Ensure initial route is set correctly
        );
      },
    );
  }
}
