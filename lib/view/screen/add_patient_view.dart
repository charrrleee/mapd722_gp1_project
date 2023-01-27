import 'package:flutter/material.dart';

import '../../framework.dart';
import '../../routes.dart';
import '../../view_model/screen/add_patient_view_model.dart';
import '../widget/appBar.dart';
import '../widget/searchBar.dart';

class AddPatientView extends StatefulWidget {
  const AddPatientView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddPatientView> createState() => AddPatientViewState();
}

class AddPatientViewState
    extends BaseMVVMState<AddPatientView, AddPatientViewModel> {
  @override
  Widget buildChild(ctx, AddPatientViewModel vm) {
    return Scaffold(
      appBar: appBar(
        "Add Patient",
        "",
        [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.home),
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              var success = vm.savePatient();
              if (success) {
                Navigator.pushNamed(
                  context,
                  Routes.viewPatient,
                  arguments: {"patientId", vm.patientId},
                );
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Column(children: [
        SearchBar(),
        // todo forms
      ]),
    );
  }

  @override
  AddPatientViewModel buildViewModel() {
    return AddPatientViewModel();
  }
}
