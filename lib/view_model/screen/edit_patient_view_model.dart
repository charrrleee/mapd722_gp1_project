import 'package:mapd722_gp1_project/model/response.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../service/patientService.dart';

class EditPatientViewModel extends BaseViewModel {
  // @override
  late Patient patient;
  var service = PatientService();

  Future<bool> updatePatient() async {
    return await service.update(patient).then((value) {
      var response = value as GetResponse;
      print("updatePatient ${response.success}");
      return true;
    }).catchError((error) {
      print("updatePatient error ${error}");
      return false;
    });
  }

  onChangeFirstName(String? text) {
    patient.firstname = text!;
    notifyListeners();
  }

  onChangeLastName(String? text) {
    patient.lastname = text!;
    notifyListeners();
  }

  onChangeHeight(String? text) {
    patient.height = double.parse(text!);
    notifyListeners();
  }

  onChangeWeight(String? text) {
    patient.weight = double.parse(text!);
    notifyListeners();
  }

  onChangeImageUrl(String? text) {
    patient.imgURL = text!;
    notifyListeners();
  }

  onDateTimeChanged(DateTime newDate) {
    patient.dateOfBirth = newDate;
    notifyListeners();
  }
}
