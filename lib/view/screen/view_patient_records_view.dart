import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/view_patient_records_view_model.dart';
import '../widget/appBar.dart';

class ViewPatientRecordsView extends StatefulWidget {
  const ViewPatientRecordsView({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<ViewPatientRecordsView> createState() => ViewPatientRecordsViewState();
}

class ViewPatientRecordsViewState
    extends BaseMVVMState<ViewPatientRecordsView, ViewPatientRecordsViewModel> {
  @override
  Widget buildChild(ctx, ViewPatientRecordsViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "${vm.patient.id} ${vm.patient.firstname} ${vm.patient.lastname}",
        "View All Patients",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, Routes.addPatientRecord),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.viewPatient),
            icon: const Icon(Icons.remove_red_eye),
          )
        ],
      ),
      body: Column(children: [
        // todo fold card
        ListView()
      ]),
    );
  }

  @override
  ViewPatientRecordsViewModel buildViewModel() {
    return ViewPatientRecordsViewModel();
  }
}
