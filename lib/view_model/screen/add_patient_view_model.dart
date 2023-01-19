import '../../framework.dart';

class AddPatientViewModel extends BaseViewModel {
  String firstname = "";
  String lastname = "";
  String idNumber = "";
  String height = "";
  String weight = "";
  String bedNumber = "";
  String gender = "";
  String dateOfBirth = "";
  String phoneNumber = "";
  String email = "";
  String address = "";
  String photoUrl = "";

  // it will be updated after api called
  String patientId = "";

  bool savePatient() {
    return false;
  }
}
