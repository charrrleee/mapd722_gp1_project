import 'package:mapd722_gp1_project/model/patient.dart';
import 'package:mapd722_gp1_project/model/patientRecord.dart';
import 'package:mapd722_gp1_project/model/response.dart';
import 'package:mapd722_gp1_project/service/patientService.dart';
import 'package:rxdart/rxdart.dart';

import '../../framework.dart';
import '../../service/patientRecordService.dart';

class HomeViewModel extends BaseViewModel {
  Map<String, Patient> patientMap = {};

  HomeViewModel() {
    Rx.combineLatest2(
      PatientService().fetch().asStream(),
      PatientRecordService()
          .fetch(
            DateTime.now().subtract(const Duration(days: 7)),
            DateTime.now(),
            "",
          )
          .asStream(),
      (resp1, resp2) {
        // todo handle connection error case
        for (var e in (resp1 as ListResponse).list!) {
          var patient = Patient.fromJson(e);
          patientMap[patient.id] = patient;
        }
        for (var e in (resp2 as ListResponse).list!) {
          var record = PatientRecord.fromJson(e);
          var patient = patientMap[record.patientId];
          patient?.records.add(record);
          if (record.critical.isNotEmpty) {
            patient?.criticalRecords[record.category] = record;
          }
        }
      },
    ).listen((event) {
      notifyListeners();
    });
  }
}
