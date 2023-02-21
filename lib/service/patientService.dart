import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/patient.dart';
import '../model/response.dart';

class PatientService {
  // String baseURL = "https://gp5.onrender.com";
  String baseURL = "http://localhost:5001";

  Future<ListResponse?> fetch() async {
    String url = "$baseURL/patients";
    var resp = await http.get(Uri.parse(url)).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return ListResponse.fromJson(jsonResponse);
    });
    return resp;
  }

  Future<GetResponse?> update(Patient patient) async {
    String url = "$baseURL/patients";
    return http.patch(Uri.parse(url), body: patient.toJson(), headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return GetResponse.fromJson(jsonResponse);
    });
  }

  Future<GetResponse?> create(Patient patient) async {
    String url = "$baseURL/patients";
    return await http.post(Uri.parse(url), body: patient.toJson(), headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return GetResponse.fromJson(jsonResponse);
    });
  }

  Future<GetResponse?> get(String patientId) async {
    String url = "$baseURL/patients/$patientId}";
    return await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }).then((response) {
      var jsonResponse = jsonDecode(response.body);
      return GetResponse.fromJson(jsonResponse);
    });
  }
}
