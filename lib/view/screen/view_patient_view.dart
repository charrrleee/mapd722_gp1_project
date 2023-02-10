import 'package:flutter/material.dart';
import 'package:mapd722_gp1_project/model/patient.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/view_patient_view_model.dart';
import '../widget/appBar.dart';
import '../widget/text.dart';

class ViewPatientView extends StatefulWidget {
  const ViewPatientView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ViewPatientView> createState() => ViewPatientViewState();
}

class ViewPatientViewState
    extends BaseMVVMState<ViewPatientView, ViewPatientViewModel> {
  @override
  Widget buildChild(ctx, ViewPatientViewModel vm) {
    vm.patient = ModalRoute.of(ctx)!.settings.arguments as Patient;

    return Scaffold(
      appBar: appBar(
        "${vm.patient.id} ${vm.patient.firstname} ${vm.patient.lastname}",
        "Patient Overview",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.editPatient),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, Routes.viewPatientRecords),
            icon: const Icon(Icons.document_scanner),
          )
        ],
      ),
      body: Column(children: [
        // todo make the rows as reuse components
        Column(
          children: [
            const SizedBox(height: 50),
            Image.network(vm.patient.imgURL),
            const SizedBox(height: 50),
            Row(
              children: [
                textFieldStyleText("First Name", vm.patient.firstname),
                textFieldStyleText("Last Name", vm.patient.lastname),
              ],
            ),
            Row(
              children: [
                textFieldStyleText("Gender", vm.patient.gender),
                textFieldStyleText(
                    "Disabled", vm.patient.disabled ? "Yes" : "No"),
              ],
            ),
            Row(
              children: [
                textFieldStyleText("Date of Birth", vm.patient.dateOfBirth.toIso8601String().substring(0,10)),
              ],
            ),
            Row(
              children: [
                textFieldStyleText("Height", vm.patient.height.toString()),
                textFieldStyleText("Weight", vm.patient.weight.toString()),
              ],
            ),
          ],
        )
      ]),
    );
  }

  @override
  ViewPatientViewModel buildViewModel() {
    return ViewPatientViewModel();
  }
}
