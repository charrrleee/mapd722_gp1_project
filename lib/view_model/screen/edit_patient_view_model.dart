import '../../framework.dart';
import '../../model/patient.dart';

class EditPatientViewModel extends BaseViewModel {
  late Patient patient;

  bool updatePatient() {
    return false;
  }

  onChangeFirstName(String? text) {}

  onChangeLastName(String? text) {}

  onChangeHeight(String? text) {}

  onChangeWeight(String? text) {}

  onChangeImageUrl(String? text) {}

  onDateTimeChanged(DateTime newDate) {
    patient.dateOfBirth = newDate;
    notifyListeners();
  }
}
