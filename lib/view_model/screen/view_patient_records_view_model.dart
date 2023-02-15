import 'package:mapd722_gp1_project/model/response.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../model/patientRecord.dart';
import '../../service/patientRecordService.dart';

class ViewPatientRecordsViewModel extends BaseViewModel {
  late Patient patient;
  List<PatientRecord> patientRecords = [];
  var service = PatientRecordService();

  Future<ListResponse?> getPatientRecords() {
    return service
        .fetch(DateTime.now().subtract(const Duration(days: 7)), DateTime.now(),
            patient.id)
        .then((value) => value);
  }
}
