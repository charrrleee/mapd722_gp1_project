enum CategoryEnum {
  bloodPressure("BLOOD_PRESSURE"),
  respiratoryRate("RESPIRATORY_RATE"),
  bloodOxygenLevel("BLOOD_OXYGEN_LEVEL"),
  heartbeatRate("HEARTBEAT_RATE");

  final String text;

  const CategoryEnum(this.text);
}

//
Map<String, CategoryEnum> parseCategory = {
  "BLOOD_PRESSURE": CategoryEnum.bloodPressure,
  "RESPIRATORY_RATE": CategoryEnum.respiratoryRate,
  "BLOOD_OXYGEN_LEVEL": CategoryEnum.bloodOxygenLevel,
  "HEARTBEAT_RATE": CategoryEnum.heartbeatRate,
};

Map<CategoryEnum, String> parseCategoryString = {
  CategoryEnum.bloodPressure: "Blood Pressure",
  CategoryEnum.respiratoryRate: "Respiratory Rate",
  CategoryEnum.bloodOxygenLevel: "Blood Oxygen Level",
  CategoryEnum.heartbeatRate: "Heartbeat Rate",
};
