import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../framework.dart';
import '../../model/simple_patient.dart';

class HomeViewModel extends BaseViewModel {
  List<SimplePatient> recommendList = [];

  HomeViewModel() {
    fetchPatient();
  }

  fetchPatient() async {
    String url = "https://gp5.onrender.com/patients";
    List<dynamic> patients = [];
    await http.get(Uri.parse(url)).then((response) {
      patients = jsonDecode(response.body)["data"] as List<dynamic>;
      recommendList = patients.map((element) {
        return SimplePatient(
            "${element["id"]}",
            "${element["firstName"]} ${element["lastName"]}",
            "${element["bedNumber"]}");
      }).toList();
      notifyListeners();
    });
  }
}
