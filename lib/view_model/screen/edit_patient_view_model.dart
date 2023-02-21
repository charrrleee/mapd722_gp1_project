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
  validateEmptyOrNull(String? value){
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
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
  validateHeight(String? value){
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if ( num.tryParse(value) == null || num.parse(value!) < 50 || num.parse(value!) > 250) {
      return 'Please enter a number in range 50 - 250';
    }
    return null;
  }

  onChangeWeight(String? text) {
    patient.weight = double.parse(text!);
    notifyListeners();
  }

  validateWeight(String? value){
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if ( num.tryParse(value) == null || num.parse(value!) < 1 || num.parse(value!) > 250) {
      return 'Please enter a number in range 1 - 250';
    }
    return null;
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
