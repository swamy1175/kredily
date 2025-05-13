import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:kredily_assessment/view/home_page.dart';
import 'package:kredily_assessment/view/reminder_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz2;

import 'notification.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
  final String localTimeZone = await FlutterTimezone.getLocalTimezone();
  tz2.setLocalLocation(tz2.getLocation(localTimeZone));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/reminder': (_) => SetReminderPage(userName: "Swamy Manda"),
      },
    );
  }
}