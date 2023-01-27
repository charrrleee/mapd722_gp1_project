import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/add_patient_record_view_model.dart';
import '../widget/appBar.dart';

class AddPatientRecordView extends StatefulWidget {
  const AddPatientRecordView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddPatientRecordView> createState() => AddPatientRecordViewState();
}

class AddPatientRecordViewState
    extends BaseMVVMState<AddPatientRecordView, AddPatientRecordViewModel> {
  @override
  Widget buildChild(ctx, AddPatientRecordViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "Medical Record",
        "Add Medical Record",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              var success = vm.savePatientRecord();
              if (success) {
                Navigator.pushNamed(
                  context,
                  Routes.viewPatientRecords,
                  arguments: {"patientId", vm.patientId},
                );
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Column(children: [
        // todo forms
      ]),
    );
  }

  @override
  AddPatientRecordViewModel buildViewModel() {
    return AddPatientRecordViewModel();
  }
}
