import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapd722_gp1_project/model/patientRecord.dart';

import '../model/response.dart';

class PatientRecordService {
  String baseURL = "https://gp5.onrender.com";

  Future<ListResponse?> fetch(
      DateTime startDate, DateTime endDate, String patientId) async {
    var url = "$baseURL/tests";
    var filters = {
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
    };
    if (patientId.isNotEmpty) {
      filters["patientId"] = patientId;
    }
    Uri uri = Uri.parse(url).replace(queryParameters: filters);
    var resp = await http.get(uri).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return ListResponse.fromJson(jsonResponse);
    });
    return resp;
  }

  Future<GetResponse?> create(PatientRecord record) async {
    var url = "$baseURL/patients/${record.patientId}/tests/";
    var resp = await http.post(Uri.parse(url), body: record).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return GetResponse.fromJson(jsonResponse);
    });
    return resp;
  }
}
