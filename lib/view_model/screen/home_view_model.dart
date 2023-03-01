import 'package:mapd722_gp1_project/model/patient.dart';
import 'package:mapd722_gp1_project/model/patient_record.dart';
import 'package:mapd722_gp1_project/model/response.dart';
import 'package:mapd722_gp1_project/service/patient_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../framework.dart';
import '../../service/patient_record_service.dart';

class HomeViewModel extends BaseViewModel {
  Map<String, Patient> patientMap = {};
  Map<String, bool> patientHidden = {};

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
          Uri? uri = Uri.tryParse(patient.imgURL);
          // check url is valid
          if (!uri!.hasAbsolutePath) {
            continue;
          }
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

  filterPatient(String input) {
    if(input.isEmpty) { 
      patientHidden = {}; 
      return;
    }
    for(Patient p in patientMap.values){
      if( p.bedNumber.toLowerCase().contains( input.toLowerCase())
       || p.firstname.toLowerCase().contains( input.toLowerCase())
       || p.lastname.toLowerCase().contains( input.toLowerCase())){
        patientHidden[p.id] = false;
      } else { patientHidden[p.id] = true; }
    }
  }
}
