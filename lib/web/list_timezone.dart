import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../Model/timezone_model.dart';
import '../routes.dart';

class TimeZonePage extends StatefulWidget {
  final ValueNotifier<String> selectedTimeZone;

  TimeZonePage({Key? key, required this.selectedTimeZone}) : super(key: key);

  @override
  _TimeZonePageState createState() => _TimeZonePageState();
}

class _TimeZonePageState extends State<TimeZonePage> {
  late Future<List<TimeZone>> _timeZones;

  Future<List<TimeZone>> fetchTimeZones() async {
    final response = await rootBundle.loadString('Assets/data/timezones.json');
    final json = jsonDecode(response) as Map<String, dynamic>;
    return (json['time_zones'] as List)
        .map((data) => TimeZone.fromJson(data))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _timeZones = fetchTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time Zone'),
      ),
      body: FutureBuilder<List<TimeZone>>(
        future: _timeZones,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].mainCity),
                  subtitle: Text(snapshot.data![index].offset),
                  onTap: () {
                    widget.selectedTimeZone.value =
                        snapshot.data![index].offset;
                    Navigator.pushNamed(context, Routes.accueil);
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
