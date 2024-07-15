import 'package:app_fusio_horaire/routes.dart';
import 'package:flutter/material.dart';

class ThemeSwapper extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;

  ThemeSwapper(this.notifier);

  @override
  _ThemeSwapperState createState() => _ThemeSwapperState();
}

class _ThemeSwapperState extends State<ThemeSwapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Quel mode de thème préférez-vous ?'),

            /// Bouton pour changer de thème
            ElevatedButton(
              onPressed: () => widget.notifier.value =
                  widget.notifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light,
              child: Text('Thème'),
            ),
            SizedBox(height: 20),

            /// Bouton pour aller dans la page d'accueil
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.accueil,
                  arguments: {
                    'selectedTimeZone': ValueNotifier<String>("UTC+00:00")
                  },
                );
              },
              child: Text("""Start l'app?"""),
            ),
          ],
        ),
      ),
    );
  }
}
