import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsWeb extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier; // For theme switching
  final ValueNotifier<bool> use24HourFormat; // For time format

  SettingsWeb({Key? key, required this.notifier, required this.use24HourFormat})
      : super(key: key);

  @override
  _SettingsWebState createState() => _SettingsWebState();
}

class _SettingsWebState extends State<SettingsWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Quel mode de thème préférez-vous ?'),

            /// Bouton pour changer de thème
            ElevatedButton(
              onPressed: () {
                widget.notifier.value = widget.notifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
                print('Theme mode: ${widget.notifier.value}');
              },
              child: Text('Thème'),
            ),

            SizedBox(height: 20),

            ValueListenableBuilder<bool>(
              valueListenable: widget.use24HourFormat,
              builder: (context, use24HourFormat, child) {
                return Text(
                  'Format de l\'heure actuel: \n${use24HourFormat ? '24 heures' : 'AM/PM'}',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),

            /// Bouton pour changer le format de l'heure
            ElevatedButton(
              onPressed: () =>
                  widget.use24HourFormat.value = !widget.use24HourFormat.value,
              child: Text('Format de l\'heure'),
            ),
          ],
        ),
      ),
    );
  }
}
