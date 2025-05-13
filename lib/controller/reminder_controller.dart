import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../notification.dart';

class ReminderController extends GetxController {
  DateTime checkInTime = DateTime.now().add( const Duration(seconds: 5));

  DateTime checkOutTime = DateTime.now().add( const Duration(seconds: 10));
  var isCheckInEnabled = true.obs;
  var isCheckOutEnabled = true.obs;

  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    _initializeNotifications();
    super.onInit();
  }

  Future<void> _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await notificationsPlugin.initialize(settings);
  }

  Future<void> scheduleNotifications(String userName) async {
    await notificationsPlugin.cancelAll();

    if (isCheckInEnabled.value) {
      NotificationService.scheduleNotification(1,  "Hi $userName", "Don’t forget to check-in!", checkInTime);
      Get.snackbar("Success", "Reminders scheduled!");
    }

    if (isCheckOutEnabled.value) {
      NotificationService.scheduleNotification(2,   "Time to check-out for the day!", "", checkOutTime);

    }
  }

  /*Future<void> _scheduleNotification({
    required int id,
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    final now = TimeOfDay.now();
    final scheduledDate = DateTime.now().add(Duration(
      days: (now.hour > time.hour || (now.hour == time.hour && now.minute >= time.minute)) ? 1 : 0,
    ));

    final scheduledTime = DateTime(
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      time.hour,
      time.minute,
    );

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails('reminder_channel', 'Reminders'),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }*/
}
