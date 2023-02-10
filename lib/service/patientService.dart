import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/patient.dart';
import '../model/response.dart';

class PatientService {
  String baseURL = "https://gp5.onrender.com";

  Future<ListResponse?> fetch() async {
    String url = "$baseURL/patients";
    var resp = await http.get(Uri.parse(url)).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return ListResponse.fromJson(jsonResponse);
    });
    return resp;
  }

  update(Patient patient) async {
    String url = "$baseURL/patients";
    await http.patch(Uri.parse(url), body: patient, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return GetResponse.fromJson(jsonResponse);
    });
  }

  create(Patient patient) async {
    String url = "$baseURL/patients";
    await http.post(Uri.parse(url), body: patient, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return GetResponse.fromJson(jsonResponse);
    });
  }

  get(String patientId) async {
    String url = "$baseURL/patients/$patientId}";
    await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return GetResponse.fromJson(jsonResponse);
    });
  }
}
