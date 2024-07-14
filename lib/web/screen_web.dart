import 'package:app_fusio_horaire/Components/components.dart';

import 'package:app_fusio_horaire/web/settings_web.dart';
import 'package:flutter/material.dart';

import 'accueil_web.dart';
import 'list_timezone.dart';

class ScreenWeb extends StatefulWidget {
  @override
  _ScreenWebState createState() => _ScreenWebState();
}

class _ScreenWebState extends State<ScreenWeb> {
  int _currentIndex = 0;
  final _pageController = PageController();
  final _use24HourFormat = ValueNotifier<bool>(true);
  final _selectedTimeZone = ValueNotifier<String>("UTC+00:00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          // Your three pages go here
          AccueilWeb(
            use24HourFormat: _use24HourFormat,
            selectedTimeZone: _selectedTimeZone,
          ),
          TimeZonePage(selectedTimeZone: _selectedTimeZone),
          SettingsWeb(
              notifier: ValueNotifier(ThemeMode.system),
              use24HourFormat: _use24HourFormat),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar1(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        },
      ),
    );
  }
}
