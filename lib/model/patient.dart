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

  Patient(this.id, this.firstname, this.lastname, this.bedNumber,
      this.dateOfBirth, this.weight, this.height, this.imgURL);

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        json["id"],
        json["firstName"],
        json["lastName"],
        json["bedNumber"],
        json["dateOfBirth"],
        double.parse(json["weight"].toString()),
        double.parse(json["height"].toString()),
        json["photoUrl"]);
  }
}
