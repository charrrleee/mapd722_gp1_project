import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/view_patient_view_model.dart';
import '../widget/appBar.dart';

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
            // todo add image url component
            Row(
              children: [
                const Text("name"),
                Text(vm.patient.lastname),
              ],
            ),
            Row(
              children: [
                const Text("Date of Birth"),
                Text(vm.patient.dateOfBirth)
              ],
            ),
            Row(
              children: [
                const Text("height"),
                Text(vm.patient.height.toString()),
              ],
            ),
            Row(
              children: [
                const Text("weight"),
                Text(vm.patient.weight.toString()),
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
