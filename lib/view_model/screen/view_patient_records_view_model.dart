import '../../framework.dart';
import '../../model/patient.dart';
import '../../model/patientRecord.dart';

class ViewPatientRecordsViewModel extends BaseViewModel {
  late Patient patient;
  List<PatientRecord> patientRecords = [];
}
