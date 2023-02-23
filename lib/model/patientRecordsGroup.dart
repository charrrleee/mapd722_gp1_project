import 'package:mapd722_gp1_project/ext.dart';
import 'package:mapd722_gp1_project/model/patientRecord.dart';
import "package:collection/collection.dart";
import '../enums.dart';

class PatientRecordsGroup {
  final DateTime modifyDate;
  final String nurseName;
  final List<PatientRecord> patientRecords;
  final bool critical;

  PatientRecordsGroup(
    this.modifyDate,
    this.nurseName,
    this.patientRecords,
    this.critical
  );

  factory PatientRecordsGroup.fromJson(MapEntry<dynamic, List<Map<String, dynamic>>> json) {
    print(json.key.runtimeType);
    List<PatientRecord> _patientRecords = [];
    bool isCritical = false;
    json.value.forEach((element) { 
      var rec = PatientRecord.fromJson(element);
      if (rec.critical.isNotEmpty) isCritical = true;
      _patientRecords.add(rec)  ;
    });
    PatientRecordsGroup record = PatientRecordsGroup(
      DateTime.parse(json.key),
      _patientRecords[0].nurseName,
      _patientRecords,
      isCritical
    );
    print(record.modifyDate.runtimeType);
    return record;
  }
}

