import 'package:mapd722_gp1_project/model/patient.dart';
import 'package:mapd722_gp1_project/service/patientService.dart';

import '../../framework.dart';

class HomeViewModel extends BaseViewModel {
  List<Patient> patientList = [];

  HomeViewModel() {
    try {
      PatientService().fetch().then((response) {
        if (response!.success == true) {
          print(response.list![0]);
          patientList = response.list!.map((e) => Patient.fromJson(e)).toList();
        }
        print("????");
        notifyListeners();
      });
    } catch (e) {
      print("???? $e");
    }
  }
}
