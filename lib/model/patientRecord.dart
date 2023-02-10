import 'package:mapd722_gp1_project/ext.dart';

class PatientRecord {
  final String id;
  final String patientId;
  final String nurseName;
  final String modifyDate;
  final String category;
  final String readings;
  String? critical;

  PatientRecord(
    this.id,
    this.patientId,
    this.nurseName,
    this.modifyDate,
    this.category,
    this.readings,
  );

  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    PatientRecord record = PatientRecord(
      json.get("id", ""),
      json["patientId"],
      json["nurseName"],
      json["modifyDate"],
      json["category"],
      json["readings"],
    );
    record.critical = markCriticalCondition(record.readings, record.category);
    return record;
  }
}

markCriticalCondition(String readings, String category) {
  List<String> ranges = readings.split(",");
  double boundary = double.parse(ranges[0]);
  String critical = "";
  switch (category) {
    case "BLOOD_PRESSURE":
      double upperBoundary = double.parse(ranges[1]);
      if (boundary > 140 || upperBoundary > 90) {
        critical = "High";
      } else if (boundary < 60 || upperBoundary < 90) {
        critical = "Low";
      }
      break;
    case "RESPIRATORY_RATE":
      if (boundary > 24) {
        critical = "High";
      } else if (boundary < 10) {
        critical = "Low";
      }
      break;

    case "BLOOD_OXYGEN_LEVEL":
      if (boundary < 92) {
        critical = "Low";
      }
      break;

    case "HEARTBEAT_RATE":
      if (boundary > 100) {
        critical = "High";
      } else if (boundary < 60) {
        critical = "Low";
      }
      break;
  }
  return critical;
}
