import 'package:flutter/cupertino.dart';
import 'package:mapd722_gp1_project/model/patientRecord.dart';

import '../../enums.dart';
import '../../framework.dart';
import '../../model/patient.dart';
import '../../service/patientRecordService.dart';

class AddPatientRecordViewModel extends BaseViewModel {
  // it will be updated after api called
  late Patient patient;
  DateTime recordDateTime = DateTime.now();
  int bloodPressureUpper = 0;
  int bloodPressureLower = 0;
  int respiratoryRate = 0;
  int bloodOxygenLevel = 0;
  int heartBeatRate = 0;
  String nurseName = "";
  var service = PatientRecordService();

  onChangeBloodPressureUpper(String? text) {
    bloodPressureUpper = int.parse(text!);
    notifyListeners();
  }

  onChangeBloodPressureLower(String? text) {
    bloodPressureLower = int.parse(text!);
    notifyListeners();
  }

  onChangeRespiratoryRate(String? text) {
    respiratoryRate = int.parse(text!);
    notifyListeners();
  }

  onChangeBloodOxygenLevel(String? text) {
    bloodOxygenLevel = int.parse(text!);
    notifyListeners();
  }

  onChangeHeartBeatRate(String? text) {
    heartBeatRate = int.parse(text!);
    notifyListeners();
  }

  onChangeRecordDateTime(DateTime? dateTime) {
    recordDateTime = dateTime!;
    notifyListeners();
  }

  onChangeNurseName(String? text) {
    nurseName = text!;
    notifyListeners();
  }

  // todo hard code nurse name
  savePatientRecord() async {
    var records = {
      CategoryEnum.bloodPressure: [bloodPressureLower, bloodPressureUpper],
      CategoryEnum.bloodOxygenLevel: [bloodOxygenLevel],
      CategoryEnum.heartbeatRate: [heartBeatRate],
      CategoryEnum.respiratoryRate: [respiratoryRate],
    };
    var results = [];
    for (var category in records.keys) {
      var rateList = records[category];
      if (rateList!.contains(0)) {
        continue;
      }
      var readings = rateList.join(",");

      var response = await service.create(
        PatientRecord(
          DateTime.now().millisecondsSinceEpoch.toString(),
          patient.id,
          nurseName,
          recordDateTime,
          category,
          readings,
        ),
      ).then((value) => true);
      results.add(response);
    }
    return !results.contains(false);
  }
}
