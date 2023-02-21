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

  validateEmptyOrNull(String? value){
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  onChangeFirstName(String? text) {
    firstname = text!;
    notifyListeners();
  }
  validateFirstName(String? text){
    if (text!.length > 50) {
      return 'Should be less than';
    }
    return null;
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

  validateHeight(String? value){
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if ( num.tryParse(value) == null
    || num.parse(value!) < 50 
    || num.parse(value!) > 250) {
      return 'Please enter a number in range 50 - 250';
    }
    return null;
  }

  onChangeWeight(String? text) {
    weight = text!;
    notifyListeners();
  }

  validateWeight(String? value){
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (num.tryParse(value) == null || num.parse(value!) < 1 || num.parse(value!) > 250) {
      return 'Please enter a number in range 1 - 250';
    }
    return null;
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

  validatePhone(String? value){
     if (value == null || value.isEmpty) {
      return 'This field is required';
    } 
    return RegExp(r"^(?:[+0]9)?[0-9]{10}$")
      .hasMatch(value!) ? null : "Please enter a valid phone number";
  }

  onChangeEmail(String? text) {
    email = text!;
    notifyListeners();
  }
  validateEmail(String? value){
     if (value == null || value.isEmpty) {
      return 'This field is required';
    } 
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value!) ? null : "Please enter a valid email";
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
