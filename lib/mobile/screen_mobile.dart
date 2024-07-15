import 'package:flutter/material.dart';
import 'accueil_mobile.dart';
import 'list_timezone.dart';
import 'settings_mobile.dart';

class ScreenMobile extends StatefulWidget {
  final ValueNotifier<String> selectedTimeZone;

  ScreenMobile({required this.selectedTimeZone});
  @override
  _ScreenMobileState createState() => _ScreenMobileState();
}

class _ScreenMobileState extends State<ScreenMobile> {
  int _currentIndex = 0;
  final _pageController = PageController();
  final _use24HourFormat = ValueNotifier<bool>(true);
  final ValueNotifier<String> _selectedTimeZone =
      ValueNotifier<String>("UTC+00:00");

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
          AccueilMobile(
            use24HourFormat: _use24HourFormat,
            selectedTimeZone: _selectedTimeZone,
          ),
          TimeZonePage(selectedTimeZone: _selectedTimeZone),
          SettingsMobile(
            notifier: ValueNotifier(ThemeMode.system),
            use24HourFormat: _use24HourFormat,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (index == 1) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TimeZonePage(selectedTimeZone: _selectedTimeZone),
              ),
            );
          } else {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          }
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
