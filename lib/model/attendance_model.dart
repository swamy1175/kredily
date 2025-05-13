class AttendanceModel {
  final DateTime checkIn;
  final DateTime? checkOut;
  final String selfiePath;
  final double latitude;
  final double longitude;

  AttendanceModel({
    required this.checkIn,
    this.checkOut,
    required this.selfiePath,
    required this.latitude,
    required this.longitude,
  });
}