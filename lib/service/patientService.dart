import 'dart:convert';

import 'package:http/http.dart' as http;

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
}
