import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredily_assessment/view/reminder_page.dart';

import '../controller/attendance_controller.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Timeline")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              controller.toggleAttendance();
              setState(() {

              });
            },
            child: Text("Check-In"),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.logs.length,
              itemBuilder: (context, index) {
                final log = controller.logs[index];
                print('swamysam ${log.checkOut}');
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.file(
                        File(log.selfiePath.toString()),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                          "In: ${log.checkIn.toLocal().toString().substring(0, 16)}\nOut: ${log.checkOut?.toLocal().toString().substring(0, 16) ?? '---'}"),
                      subtitle: Column(
                        children: [
                          Text("Lat: ${log.latitude}, Lng: ${log.longitude}"),
                          log.checkOut ==null ? MaterialButton(onPressed: (){
                            controller.checkout();
                          },
                            color: Colors.indigo,child: Text('Check out',style: TextStyle(color: Colors.white),),
                          ):SizedBox()
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
          MaterialButton(onPressed: (){
            Get.to(()=>SetReminderPage(userName: "Swamy Manda",));
          },color: Colors.indigo,child: Text('Set Reminders',style: TextStyle(color: Colors.white),),)
        ],
      ),
    );
  }
}