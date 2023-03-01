import 'package:mapd722_gp1_project/model/response.dart';

import '../../framework.dart';
import '../../model/patient.dart';
import '../../model/patient_record.dart';
import '../../model/patient_records_group.dart';
import '../../service/patient_record_service.dart';
import 'package:rxdart/rxdart.dart';

import "package:collection/collection.dart";

class ViewPatientRecordsViewModel extends BaseViewModel {
  late Patient patient;
  var currentStartDate = DateTime.now().subtract(const Duration(days: 7));
  var currentEndDate = DateTime.now();
  List<PatientRecordsGroup> patientRecordsGroup = [];
  var service = PatientRecordService();

  Future<List<PatientRecordsGroup>> getPatientRecords() {
    print("Fetching ${currentStartDate} - ${currentEndDate}");
    return service.fetch(currentStartDate, currentEndDate, patient.id).then(
        (data) {
      var groupedList = groupBy(data?.list as Iterable<Map<String, dynamic>>,
          (Map<String, dynamic> obj) => obj['modifyDate']).entries.toList();
      groupedList.forEach((element) {
        var record = PatientRecordsGroup.fromJson(element);
        patientRecordsGroup.add(record);
      });
      return patientRecordsGroup;
    }).whenComplete(() => {
          currentStartDate = currentStartDate.subtract(const Duration(days: 7)),
          currentEndDate = currentEndDate.subtract(const Duration(days: 7))
        });
  } 
}
