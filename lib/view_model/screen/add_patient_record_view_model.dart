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

  validateEmptyOrNull(String? value){
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
  onChangeBloodPressureUpper(String? text) {
    bloodPressureUpper = text!.isNotEmpty ? int.parse(text!) : 0;
    notifyListeners();
  }

  onChangeBloodPressureLower(String? text) {
    bloodPressureLower = text!.isNotEmpty ? int.parse(text!) : 0;
    notifyListeners();
  }
  
  validateBP(String? value){
    if ( value != null && value.isNotEmpty &&  ( num.tryParse(value) == null || num.parse(value!) < 50 || num.parse(value!) > 250)) {
      return 'Please enter a number in range 50 - 250';
    }
    return null;
  }

  onChangeRespiratoryRate(String? text) {
    respiratoryRate = text!.isNotEmpty ? int.parse(text!) : 0;
    notifyListeners();
  }

  validateRR(String? value){
    if ( value != null && value.isNotEmpty &&  ( num.tryParse(value) == null || num.parse(value!) < 50 || num.parse(value!) > 250)) {
      return 'Please enter a number in range 2 - 90';
    }
    return null;
  }
  onChangeBloodOxygenLevel(String? text) {
    bloodOxygenLevel = text!.isNotEmpty ? int.parse(text!) : 0;
    notifyListeners();
  }

  validateBO(String? value){
    if ( value != null && value.isNotEmpty && ( num.tryParse(value) == null || num.parse(value!) < 50 || num.parse(value!) > 250)) {
      return 'Please enter a number in range 0 - 100';
    }
    return null;
  }
  onChangeHeartBeatRate(String? text) {
    heartBeatRate = text!.isNotEmpty ? int.parse(text!) : 0;
    notifyListeners();
  }

  validateHBR(String? value){
    if ( value != null && value.isNotEmpty &&  ( num.tryParse(value) == null || num.parse(value!) < 50 || num.parse(value!) > 250)) {
      return 'Please enter a number in range 0 - 200';
    }
    return null;
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
      CategoryEnum.bloodPressure: [bloodPressureUpper, bloodPressureLower],
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
