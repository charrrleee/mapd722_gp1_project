import '../../framework.dart';
import '../../model/patient.dart';

class ViewPatientsViewModel extends BaseViewModel {
  List<Patient> patients = [];
  Map<String, bool> patientHidden = {};


  filterPatient(String input) {
    if(input.isEmpty) { 
      patientHidden = {}; 
      return;
    }
    for(Patient p in patients){
      if( p.bedNumber.toLowerCase().contains( input.toLowerCase())
       || p.firstname.toLowerCase().contains( input.toLowerCase())
       || p.lastname.toLowerCase().contains( input.toLowerCase())){
        patientHidden[p.id] = false;
      } else { patientHidden[p.id] = true; }
    }
  }
}
