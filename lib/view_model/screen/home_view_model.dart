import 'package:mapd722_gp1_project/model/patient.dart';
import 'package:mapd722_gp1_project/model/patientRecord.dart';
import 'package:mapd722_gp1_project/service/patientService.dart';

import '../../framework.dart';
import '../../service/patientRecordService.dart';

class HomeViewModel extends BaseViewModel {
  List<Patient> patientList = [];
  List<PatientRecord> patientRecordList = [];

  HomeViewModel() {
    try {
      PatientService().fetch().then((response) {
        if (response!.success == true) {
          patientList = response.list!.map((e) => Patient.fromJson(e)).toList();
        }
        notifyListeners();
      });
    } catch (e) {
      print("fetch Patient List Error : $e");
    }

    try {
      PatientRecordService()
          .fetch(
        DateTime.now().subtract(const Duration(days: 7)),
        DateTime.now(),
        "",
      )
          .then((response) {
        if (response!.success == true) {
          patientList = response.list!.map((e) => Patient.fromJson(e)).toList();
        }
        notifyListeners();
      });
    } catch (e) {
      print("fetch Patient List Error : $e");
    }
  }
}
