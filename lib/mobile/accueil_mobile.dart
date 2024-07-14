import 'dart:async';
import 'package:flutter/material.dart';

class AccueilMobile extends StatefulWidget {
  final ValueNotifier<bool> use24HourFormat;
  final ValueNotifier<String> selectedTimeZone;

  AccueilMobile(
      {Key? key, required this.use24HourFormat, required this.selectedTimeZone})
      : super(key: key);

  @override
  _AccueilMobileState createState() => _AccueilMobileState();
}

class _AccueilMobileState extends State<AccueilMobile> {
  DateTime _currentTime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  DateTime _convertToSelectedTimeZone(DateTime dateTime, String offset) {
    final offsetPattern = RegExp(r'UTC([+-])(\d{2}):(\d{2})');
    final match = offsetPattern.firstMatch(offset);

    if (match == null) {
      print("Invalid timezone offset format: $offset");
      throw FormatException("Invalid timezone offset format");
    }

    final offsetSign = match.group(1);
    final offsetHours = int.parse(match.group(2)!);
    final offsetMinutes = int.parse(match.group(3)!);

    Duration offsetDuration = Duration(
      hours: offsetSign == '+' ? offsetHours : -offsetHours,
      minutes: offsetSign == '+' ? offsetMinutes : -offsetMinutes,
    );

    return dateTime.toUtc().add(offsetDuration);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.selectedTimeZone,
      builder: (context, selectedTimeZone, child) {
        DateTime localTime =
            _convertToSelectedTimeZone(_currentTime, selectedTimeZone);
        String formattedTime = _formatDateTime(localTime);

        return Center(
          child: Text(
            formattedTime,
            style: TextStyle(fontSize: 24),
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    if (widget.use24HourFormat.value) {
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
    } else {
      int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
      String period = dateTime.hour >= 12 ? "PM" : "AM";
      return "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')} $period";
    }
  }
}
