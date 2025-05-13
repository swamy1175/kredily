import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import '../model/attendance_model.dart';

class AttendanceController extends GetxController {
  RxList<AttendanceModel> logs = <AttendanceModel>[].obs;
  RxBool isCheckedIn = false.obs;

  Future<void> toggleAttendance() async {
    final selfie = await _captureSelfie();
    final location = await _getLocation();
    final now = DateTime.now();

    if (!isCheckedIn.value) {
      logs.add(AttendanceModel(
        checkIn: now,
        selfiePath: selfie.path,
        latitude: location.latitude,
        longitude: location.longitude,
      ));
      isCheckedIn.value = true;
    }
  }
  Future<void> checkout() async {
    final selfie = await _captureSelfie();
    final location = await _getLocation();
    final now = DateTime.now();
    final lastLog = logs.last;
    logs.removeLast();
    logs.add(AttendanceModel(
    checkIn: lastLog.checkIn,
    checkOut: now,
    selfiePath: selfie.path,
    latitude: location.latitude,
    longitude: location.longitude,
    ));
    isCheckedIn.value = false;
    }
  }

  Future<XFile> _captureSelfie() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) throw Exception('No image selected');
    return pickedFile;
  }

  Future<Position> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  }
