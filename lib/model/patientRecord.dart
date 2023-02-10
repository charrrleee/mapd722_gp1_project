class PatientRecord {
  final String id;
  final String patientId;
  final String nurseName;
  final String modifyDate;
  final String category;
  final String readings;
  final String? critical;

  PatientRecord(
    this.id,
    this.patientId,
    this.nurseName,
    this.modifyDate,
    this.category,
    this.readings,
    this.critical,
  );

  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    return PatientRecord(
      json["id"],
      json["patientId"],
      json["nurseName"],
      json["modifyDate"],
      json["category"],
      json["readings"],
      json["critical"],
    );
  }
}
