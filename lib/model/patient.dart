import 'package:mapd722_gp1_project/ext.dart';

class Patient {
  // todo add more fields
  final String id;
  final String firstname;
  final String lastname;
  final String bedNumber;
  final String dateOfBirth;
  final double weight;
  final double height;
  final String imgURL;

  final int idCardNumber;
  final String gender;
  final int phoneNumber;
  final String address;
  final String postalCode;
  final bool medicalAllergies;
  final bool disabled;

  // todo confirm date type
  final String createdAt;
  final String updateAt;
  final String medicalNotes;
  final String doctor;

  Patient(
      this.id,
      this.firstname,
      this.lastname,
      this.bedNumber,
      this.dateOfBirth,
      this.weight,
      this.height,
      this.imgURL,
      this.idCardNumber,
      this.gender,
      this.phoneNumber,
      this.address,
      this.postalCode,
      this.medicalAllergies,
      this.disabled,
      this.createdAt,
      this.updateAt,
      this.medicalNotes,
      this.doctor);

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      json["id"],
      json["firstName"],
      json["lastName"],
      json["bedNumber"],
      json["dateOfBirth"],
      double.parse(json["weight"].toString()),
      double.parse(json["height"].toString()),
      json["photoUrl"],
      int.parse(json["idCardNumber"].toString()),
      json["gender"],
      int.parse(json["phoneNumber"].toString()),
      json["address"],
      json.get("postalCode", ""),
      json.get("medicalAllergies", false),
      json.get("disabled", false),
      json["createdAt"],
      json["updatedAt"],
      json.get("medicalNotes", ""),
      json.get("doctor", ""),
    );
  }
}
