import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../model/patient.dart';

class PatientCard extends StatelessWidget {
  Patient patient;

  PatientCard(this.patient, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String> textList = [
      "${patient.bedNumber} ${patient.lastname} ${patient.firstname}"
    ];

    for (var element in patient.criticalRecords.entries) {
      textList.add(
          "- ${parseCategoryString[element.key]}: ${element.value.critical}");
    }
    return Container(
        width: 100,
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: textList.length > 1 ? Colors.red[900] : Colors.white),
        child: Row(
          children: [
            const Spacer(),
            Image.network(patient.imgURL),
            const Spacer(),
            Container(
              width: 200,
              child: Text(
                textList.join("\n"),
                textAlign: TextAlign.left,
                style: TextStyle(color: textList.length > 1 ? Colors.white : Colors.black)
              ),
            ),
            const Spacer(),
          ],
        ));
  }
}
