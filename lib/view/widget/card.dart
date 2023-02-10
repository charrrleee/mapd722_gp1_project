import 'package:flutter/cupertino.dart';

import '../../enums.dart';
import '../../model/patient.dart';

class PatientCard extends StatelessWidget {
  Patient patient;

  PatientCard(this.patient, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      Text("${patient.bedNumber} ${patient.lastname} ${patient.firstname}")
    ];

    for (var e in patient.records) {
      if (e.critical.isNotEmpty) {
        listWidget
            .add(Text("${parseCategoryString[e.category]} ${e.critical}"));
      }
    }
    return Row(
      children: [
        Image.network(patient.imgURL),
        const Spacer(),
        Column(
          children: listWidget,
        )
      ],
    );
  }
}
