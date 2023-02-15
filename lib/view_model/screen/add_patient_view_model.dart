import 'package:mapd722_gp1_project/model/response.dart';
import 'package:mapd722_gp1_project/service/patientService.dart';

import '../../framework.dart';
import '../../model/patient.dart';

class AddPatientViewModel extends BaseViewModel {
  String firstname = "";
  String lastname = "";
  String idNumber = "";
  String height = "";
  String weight = "";
  String bedNumber = "";
  String gender = ""; // todo selection
  DateTime dateOfBirth = DateTime.now();
  String phoneNumber = "";
  String email = "";
  String address = "";
  String imgURL = "";
  String idCardNumber = "";
  String postalCode = "";

  // it will be updated after api called
  String patientId = "";

  onChangeFirstName(String? text) {
    firstname = text!;
    notifyListeners();
  }

  onChangeLastName(String? text) {
    lastname = text!;
    notifyListeners();
  }

  onChangeIdNumber(String? text) {
    idNumber = text!;
    notifyListeners();
  }

  onChangeHeight(String? text) {
    height = text!;
    notifyListeners();
  }

  onChangeWeight(String? text) {
    weight = text!;
    notifyListeners();
  }

  onChangeBedNumber(String? text) {
    bedNumber = text!;
    notifyListeners();
  }

  onChangeGender(String? text) {
    gender = text!;
    notifyListeners();
  }

  onChangeDOB(DateTime? dateTime) {
    dateOfBirth = dateTime!;
    notifyListeners();
  }

  onChangePhoneNumber(String? text) {
    phoneNumber = text!;
    notifyListeners();
  }

  onChangeEmail(String? text) {
    email = text!;
    notifyListeners();
  }

  onChangeAddress(String? text) {
    address = text!;
    notifyListeners();
  }

  onChangeImageURL(String? text) {
    imgURL = text!;
    notifyListeners();
  }

  onChangeIdCardNumber(String? text) {
    idCardNumber = text!;
    notifyListeners();
  }

  onChangePostalCode(String? text) {
    postalCode = text!;
    notifyListeners();
  }

  var service = PatientService();

  Future<GetResponse?> savePatient() {
    var patient = Patient(
      DateTime.now().millisecondsSinceEpoch.toString(),
      firstname,
      lastname,
      bedNumber,
      dateOfBirth,
      double.parse(weight),
      double.parse(height),
      imgURL,
      int.parse(idCardNumber),
      gender,
      int.parse(phoneNumber),
      address,
      postalCode,
      false,
      false,
      DateTime.now().toIso8601String(),
      DateTime.now().toIso8601String(),
      "",
      "Charlene",
    );
    return service.create(patient).then((value) {
      return value;
    });
  }
}
