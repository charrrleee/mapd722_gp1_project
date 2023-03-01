import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../model/patient_records_group.dart';

class MedicalRecordItem extends StatelessWidget {
  PatientRecordsGroup recordsGroup;

  MedicalRecordItem(this.recordsGroup, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.grey[200],
        ),
        child: Padding(
            padding: EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (var rec in recordsGroup.patientRecords)
                Text(
                    "${parseCategoryString[rec.category]} : ${rec.readings} ${rec.critical.isNotEmpty ? '**' + rec.critical + '**' : ''}"),
              const Spacer(),
              Text(
                "Nurse: ${recordsGroup.nurseName}",
                textAlign: TextAlign.left,
              )
            ])));
  }
}
