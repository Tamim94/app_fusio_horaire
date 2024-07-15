import 'package:app_fusio_horaire/Components/components.dart';

import 'package:app_fusio_horaire/web/settings_web.dart';
import 'package:flutter/material.dart';

import 'accueil_web.dart';
import 'list_timezone.dart';

class ScreenWeb extends StatefulWidget {
  final ValueNotifier<String> selectedTimeZone;

  ScreenWeb({required this.selectedTimeZone});

  @override
  _ScreenWebState createState() => _ScreenWebState();
}

class _ScreenWebState extends State<ScreenWeb> {
  int _currentIndex = 0;
  final _pageController = PageController();
  final _use24HourFormat = ValueNotifier<bool>(true);

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
          AccueilWeb(
            use24HourFormat: _use24HourFormat,
            selectedTimeZone: widget.selectedTimeZone,
          ),
          TimeZonePage(selectedTimeZone: widget.selectedTimeZone),
          SettingsWeb(
            notifier: ValueNotifier(ThemeMode.system),
            use24HourFormat: _use24HourFormat,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Time Zone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
