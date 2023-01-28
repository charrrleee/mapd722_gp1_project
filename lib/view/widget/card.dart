import 'package:flutter/cupertino.dart';

import '../../model/patient.dart';

class PatientCard extends StatelessWidget {
  Patient patient;

  PatientCard(this.patient, {super.key});

  @override
  Widget build(BuildContext context) {
    // todo handling styling
    return Row(
      children: [
        Image.network(patient.imgURL),
        const Spacer(),
        Column(
          children: [
            Text("${patient.bedNumber} ${patient.lastname} ${patient.firstname}"),
          ],
        )
      ],
    );
  }
}
