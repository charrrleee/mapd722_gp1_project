import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/patient.dart';

class SharedPreferencesService {

  // todo put user name
  Future<Patient> getPatientSP() async {
    final prefs = await SharedPreferences.getInstance();
    String patientStr = prefs.getString("Patient")!;
    return Patient.fromJson(jsonDecode(patientStr));
  }

  setPatientSP(Patient patient) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("Patient", jsonEncode(patient.toJson()));
  }
}
