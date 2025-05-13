import 'package:flutter/material.dart';
import '../controller/reminder_controller.dart';
import 'package:get/get.dart';

import '../notification.dart';

class SetReminderPage extends StatelessWidget {
  final ReminderController controller = Get.put(ReminderController());
  final String userName;
  SetReminderPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Reminders")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => SwitchListTile(
              title: Text("Enable Check-in Reminder"),
              value: controller.isCheckInEnabled.value,
              onChanged: (val) => controller.isCheckInEnabled.value = val,
            )),
            ListTile(
              title: Text("Check-in Time"),
              trailing: Text("${controller.checkInTime}"),
              onTap: () async {

              },
            ),
            Divider(),
            Obx(() => SwitchListTile(
              title: Text("Enable Check-out Reminder"),
              value: controller.isCheckOutEnabled.value,
              onChanged: (val) => controller.isCheckOutEnabled.value = val,
            )),
            ListTile(
              title: Text("Check-out Time"),
              trailing: Text("${controller.checkOutTime}"),
              onTap: () async {
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.scheduleNotifications(userName);
              },
              child: Text("Save Reminders"),
            )
          ],
        ),
      ),
    );
  }
}
