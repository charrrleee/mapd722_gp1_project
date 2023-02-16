import 'package:mapd722_gp1_project/ext.dart';

import '../enums.dart';

class PatientRecord {
  final String id;
  final String patientId;
  final String nurseName;
  final DateTime modifyDate;
  final CategoryEnum category;
  final String readings;
  String critical = "";

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
      DateTime.parse(json["modifyDate"]),
      parseCategory[json["category"]]!,
      json["readings"],
    );
    record.critical = markCriticalCondition(record.readings, record.category);
    return record;
  }

  Map<String, dynamic> toPayload() {
    return {
      "id": id,
      "patientId": patientId,
      "nurseName": nurseName,
      "modifyDate": modifyDate.toIso8601String(),
      "category": category.text,
      "readings": readings,
    };
  }
}

markCriticalCondition(String readings, CategoryEnum category) {
  List<String> ranges = readings.split(",");
  double boundary = double.parse(ranges[0]);
  String critical = "";
  switch (category) {
    case CategoryEnum.bloodPressure:
      if (ranges.length == 1) {
        break;
      }
      double upperBoundary = double.parse(ranges[1]);
      if (boundary > 140 || upperBoundary > 90) {
        critical = "High";
      } else if (boundary < 60 || upperBoundary < 90) {
        critical = "Low";
      }
      break;
    case CategoryEnum.respiratoryRate:
      if (boundary > 24) {
        critical = "High";
      } else if (boundary < 10) {
        critical = "Low";
      }
      break;
    case CategoryEnum.bloodOxygenLevel:
      if (boundary < 92) {
        critical = "Low";
      }
      break;
    case CategoryEnum.heartbeatRate:
      if (boundary > 100) {
        critical = "High";
      } else if (boundary < 60) {
        critical = "Low";
      }
      break;
  }
  return critical;
}
